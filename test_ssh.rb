#/usr/bin/env ruby
require 'rubygems'
require 'net/ssh'
require 'net/scp'

host = "centos63a"
user = "root"
password = "vagrant"
installer_version = "puppet-enterprise-2.7.1-all.tar.gz"

Net::SSH.start(host, user, :password => password) do |ssh|
  
  unameoutput = ssh.exec! "uname -r"

  puts unameoutput

  puts "\nStarting upload of installer..." 
  ssh.scp.upload!( "/Users/cbarker/.vagrant.d/pe_builds/#{installer_version}", '.') do|ch, name, sent, total|
    print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
  end
  puts "\nExpanding installer..."
  ssh.exec! "tar xvzf #{installer_version}" do |ch, stream, data|
    if stream == :stderr
      puts "ERROR: #{data}"
    else
      puts data
    end
  end
  puts "\nUploading answers file..."
  ssh.scp.upload!( "dummy-answers.txt", 'puppet-enterprise-2.7.1-all/') do|ch, name, sent, total|
    print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
  end
  puts "\nRunning Installer..."
  ssh.exec! "echo puppet-enterprise-installer -a dummy-answers.txt" do |ch, stream, data|
    if stream == :stderr
      puts "ERROR: #{data}"
    else
      puts data
    end
  end
end

