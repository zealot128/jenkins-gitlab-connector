require 'sinatra'
require "json"
require "httparty"
require "yaml"
require "pry"

CONFIG = YAML.load_file("config.yml")

post "/" do
  data = JSON.parse request.env["rack.input"].read
  repository = data["repository"]["name"]
  branch     = data["ref"]
  $stderr.puts "Incoming request: #{repository} on branch #{branch}"

  # require "pry"; binding.pry  # need adjustments? just look into data
  branch_options = CONFIG["projects"][repository][branch] rescue false
  if branch_options
    if branch_options["build_params"]
      url = "http://#{CONFIG["ci_host"]}/job/#{branch_options["project"]}/buildWithParameters?token=#{branch_options["token"]}#{branch_options["build_params"]}"
    else
      url = "http://#{CONFIG["ci_host"]}/job/#{branch_options["project"]}/build?token=#{branch_options["token"]}#{branch_options["build_params"]}"

    end
    $stdout.puts url
    if auth = CONFIG["basic_auth"]
      # HTTParty needs auth in symbols
      opts = { basic_auth: { username: auth["username"], password: auth["password"]}}
    else
      opts = {}
    end
    puts "-> GET #{url}"
    HTTParty.get url, opts
  end
  "success"
end
