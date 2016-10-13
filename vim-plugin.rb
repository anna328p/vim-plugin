#!/usr/bin/env ruby
require 'yaml'

case ARGV[0]
when "install"
  puts ":: Getting repository information..."
  y = YAML.load raw_json = `curl -s https://api.github.com/repos/#{ARGV[1]}`

  puts "#{y["full_name"]}: #{y["description"]}"

  print ":: Install #{y["name"]}? [Y/n] "

  exit(100) if STDIN.gets.chomp.downcase == "n"

  puts "[1/2] Cloning repository #{y["full_name"]}..."
  system "git clone https://www.github.com/#{y["full_name"]} #{Dir.home}/.vim/bundle/#{y["name"]}"

  puts "[2/2] Writing information..."
  File.write(Dir.home+"/.vim/bundle/#{y["name"]}/#{y["name"]}.plugin.json", raw_json)

  puts ":: Plugin #{y["name"]} has been successfully installed."
when "remove"
  ARGV[1] = ARGV[1].split("/")[1]
  raw_json = File.read Dir.home+"/.vim/bundle/#{ARGV[1]}/#{ARGV[1]}.plugin.json";
  y = YAML.load raw_json

  puts "#{y["full_name"]}: #{y["description"]}"

  print ":: Remove #{y["name"]}? [y/N] "

  if STDIN.gets.chomp.downcase != "y" then
    STDERR << "Aborted.\n"
    exit(101)
  end

  puts "[1/1] Removing files."

  system "rm -rf #{Dir.home}/.vim/bundle/#{y["name"]}"

  puts ":: Plugin #{y["name"]} has been successfully removed."
end
