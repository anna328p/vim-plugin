#!/usr/bin/env ruby
require 'yaml'

case ARGV[0]
when "install"
  puts ":: Getting repository information..."
  y = YAML.load raw_json = `curl -s https://api.github.com/repos/#{ARGV[1]}`

  puts "#{y["name"]} (id #{y["id"]}) by #{y["owner"]["login"]} (id: #{y["owner"]["id"]})"
  puts "#{y["full_name"]}: #{y["description"]}"

  print ":: Install plugin #{y["name"]}? [Y/n] "

  exit(100) if STDIN.gets.chomp.downcase == "n"

  dir_name = "#{Dir.home}/.vim/bundle/#{y["id"]}"

  puts "(1/2) Cloning repository #{y["full_name"]}..."
  system "git clone https://www.github.com/#{y["full_name"]} #{dir_name}"

  puts "(2/2) Writing information..."
  File.write(dir_name+"/#{y["name"]}.plugin.json", raw_json)

  File.open(Dir.home+"/.vim/bundle/plugins.yml", "a") { |f|
    f.puts "#{y["id"]}: #{raw_json}"
  }

  puts ":: Plugin #{y["name"]} has been successfully installed."
when "remove"
  raw_yaml = File.read Dir.home+"/.vim/bundle/plugins.yml";
  j = YAML.load raw_yaml
  y = j[ARGV[1].to_i]

  puts "#{y["full_name"]}: #{y["description"]}"

  print ":: Remove #{y["name"]}? [y/N] "

  if STDIN.gets.chomp.downcase != "y" then
    STDERR << "Aborted.\n"
    exit(101)
  end

  puts "(1/2) Removing files..."

  system "rm -rf #{Dir.home}/.vim/bundle/#{y["name"]}"

  puts "(2/2) Writing information..."

  puts ":: Plugin #{y["name"]} has been successfully removed."
when "list"
  raw_json = File.read Dir.home+"/.vim/bundle/plugins.yml"
  y = YAML.load raw_json
  y.each do |i|
    puts i["id"]
  end

end
