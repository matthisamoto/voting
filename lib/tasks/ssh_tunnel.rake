TUNNEL_USERNAME = "deploy"
TUNNEL_HOST = "174.143.146.148"
TUNNEL_PORT = 3000

desc "Tunnel to a remote host"
task :tunnel => :environment do
  puts "Tunnel established from #{TUNNEL_HOST}:#{TUNNEL_PORT} to 127.0.0.1:3000"
  system "ssh -nNT -g -R *:#{TUNNEL_PORT}:127.0.0.1:3000 #{TUNNEL_USERNAME}@#{TUNNEL_HOST}"
end
