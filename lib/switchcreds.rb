require "switchcreds/version"
require "os"

module SwitchCreds
  def self.get_creds
    # detect the OS and user to find the .aws directory
    if OS.mac?
      $user = Dir.home[7, Dir.home.length].to_s
    elsif OS.windows?
      $user = Dir.home[9, Dir.home.length].to_s
    # when OS.linux?
      # TODO: build out Linux implentation (other OSs too?)
    else
      puts "ERROR:".colorize(:red) + " Neither WINDOWS nor MAC OS detected.\n Unable to proceed."
    end
    dir = Dir.entries("/Users/#{$user}/.aws")
    creds = []
    dir.each do |f|
      if f.length > 11 && f[0,12] == "credentials_"
        creds.push(f[12, f.length])
      end
    end
    creds
  end

  def switch_creds
    creds = get_creds()
    puts "Switch to wat?\n"

    i = 0
    creds.each do |o|
      puts "#{i}: #{o}"
      i += 1
    end

    selection = STDIN.gets.chomp.to_i
    selection = creds[selection]

    IO.copy_stream("/Users/#{$user}/.aws/credentials_#{selection}", "/Users/#{$user}/.aws/credentials")

    # this is probably a bad idea
    # File.open("/Users/#{$user}/.aws/credentials").each do |line|
    #   puts line
    # end
    32.times { print "*".colorize(:green) }
    puts "\n* Using #{selection.upcase!.colorize(:red)} creds now *\n"
    32.times { print "*".colorize(:green) }
    puts "\n"
  end

  def which_creds
    creds = get_creds
    creds.each do |cred|
      if FileUtils.compare_file("/Users/#{$user}/.aws/credentials", "/Users/#{$user}/.aws/credentials_#{cred}")
        32.times { print "*".colorize(:green) }
        puts "\n* You're using #{cred.upcase!.colorize(:red)} creds.*\n"
        32.times { print "*".colorize(:green) }
        puts "\n"
      end
    end
  end
end
