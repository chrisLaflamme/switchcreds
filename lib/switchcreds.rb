require 'switchcreds/version'
require 'os'

module SwitchCreds
  # def self.init_creds
  #   // 
  #   //
  #   //
  # end

  def self.get_creds
    # detect the OS and user to find the .aws/ directory
    if OS.mac?
      $user = Dir.home[7, Dir.home.length].to_s
    elsif OS.linux?
      $user = Dir.home[6, Dir.home.length].to_s
    elsif OS.windows?
      $user = Dir.home[9, Dir.home.length].to_s
    else
      puts 'ERROR:'.colorize(:red) + " Neither WINDOWS, MAC, nor LINUX OS detected.\n Unable to proceed."
    end
    dir = Dir.entries("/Users/#{$user}/.aws")
    creds = []
    dir.each do |f|
      if f.length > 11 && f[0,12] == 'credentials_'
        creds.push(f[12, f.length])
      end
    end
    creds
  end

  def self.switch_creds
    creds = get_creds
    puts "CHOOSE FROM BELOW:\n".colorize(:green)

    i = 0
    creds.each do |o|
      puts "\t#{i}: #{o}"
      i += 1
    end

    selection = STDIN.gets.chomp.to_i
    selection = creds[selection]

    IO.copy_stream("/Users/#{$user}/.aws/credentials_#{selection}", "/Users/#{$user}/.aws/credentials")

    32.times { print '*'.colorize(:green) }
    puts "\n* Using #{selection.upcase!.colorize(:red)} creds now *\n"
    32.times { print '*'.colorize(:green) }
    puts "\n"
  end

  def self.which_creds
    creds = get_creds
    creds.each do |cred|
      if FileUtils.compare_file("/Users/#{$user}/.aws/credentials", "/Users/#{$user}/.aws/credentials_#{cred}")
        32.times { print '*'.colorize(:green) }
        puts "\n* You're using #{cred.upcase!.colorize(:red)} creds.*\n"
        32.times { print '*'.colorize(:green) }
        puts "\n"
      end
    end
  end
end
