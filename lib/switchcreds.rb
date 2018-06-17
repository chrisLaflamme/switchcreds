require 'switchcreds/version'
require 'os'

module SwitchCreds
  def self.init_creds
    # create a different 'credentials_' file for each cred set in credentials
    user = detect_user
    default_creds_path = "/Users/#{user}/.aws/credentials"
    default_creds_dir = "/Users/#{user}/.aws/"
  
    # TODO: implement a raise unless File.file?(default_creds_path)
    default_creds = IO.readlines("/Users/#{user}/.aws/credentials")
  
    pp default_creds
    # find each [] and touch a credentials_ file with that name
    # and populate with respective keys
    default_creds.each do |line|
      if line.include?('[' && ']')
        profile_name = line.to_s
        profile_index = default_creds.find_index(profile_name)
        # remove beginning and trailing square brackets
          # TODO: switch this regex to only remove '[]'
        clean_profile_name = profile_name.strip.slice(1..(profile_name.length - 3))
        out_file = File.open("#{default_creds_dir}credentials_#{clean_profile_name}", 'w')
        open(out_file, 'w') do |f| # TODO: look into why using 'open' is a security risk
          f << profile_name
          f << "#{default_creds[profile_index + 1]}"
          f << "#{default_creds[profile_index + 2]}"
        end
      else
        puts profile_name.to_s.colorize(:red)
      end
    end
  end

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
