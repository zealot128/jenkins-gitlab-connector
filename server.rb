require 'sinatra'
require "json"
require "httparty"
require "yaml"

CONFIG = YAML.load_file("config.yml")

post "/" do
  data = JSON.parse request.env["rack.input"].read
  project = CONFIG["projects"][data["ref"]]
  if project
    url = "http://#{CONFIG["ci_host"]}/job/#{project}/build?token=#{CONFIG["token"]}"
    $stdout.puts url
    if auth = CONFIG["basic_auth"]
      # HTTParty needs auth in symbols
      opts = { basic_auth: { username: auth["username"], password: auth["password"]}}
    else
      opts = {}
    end
    HTTParty.get url, opts
  end
  "success"
end
