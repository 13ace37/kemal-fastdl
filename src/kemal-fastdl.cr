require "kemal"
require "option_parser"
server_path = ""
port = "36949"

module Kemal::Fastdl
	VERSION = "0.0.1"
	OptionParser.parse do |parser|
		parser.banner = "kemal-fastdl by ace"
	  
		parser.on "-v", "--version", "Show version" do
			puts VERSION
			exit
		end
		parser.on "-h", "--help", "Show help" do
			puts parser
			exit
		end
		parser.on "-d DIR", "--dir=DIR", "Starts server with given dir" do |dir|
			server_path = dir
		end
		parser.on "-p PORT", "--port=PORT", "Starts server with custom port" do |cport|
			port = cport
		end
	end
	unless server_path.empty?
		if !Dir.exists?(server_path)
			puts "ERROR: Invalid dir provided!\nCheck \"./kemal-fastdl -h\" for more information."
			exit
		end
		get "/*" do |env|
			file = Path.new(server_path, env.request.path.sub("../", "/"))
			if File.exists?(file) && File.file?(file) && !File.empty?(file) && env.request.path != "/"
				send_file env, file.to_s
			else
				env.response.respond_with_status(404)
			end
		end
		Kemal.run do |config|
			server = config.server.not_nil!
			server.bind_tcp "0.0.0.0", port.to_i32, reuse_port: true
		end
	end
end
