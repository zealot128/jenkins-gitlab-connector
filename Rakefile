PORT = 3850
cmd_options = "-P pid.pid -p #{PORT} -R config.ru"

desc "start thin on port #{3850}"
task :start do
  sh "thin start #{cmd_options} -d "
  puts "Started on Port #{PORT}"
end

desc "start thin on port #{3850}"
task :start_in_foreground do
  sh "thin start #{cmd_options}"
end

desc "restart"
task :restart do
  sh "thin restart #{cmd_options}"
  puts "Restarted"
end

desc "stop"
task :stop do
  sh "thin stop #{cmd_options}"
  puts "Stopped Thin"
end
