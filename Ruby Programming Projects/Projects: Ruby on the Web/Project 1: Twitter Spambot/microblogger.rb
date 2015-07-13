require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if not message.size.between?(0,140)
      puts "Tweet too long"
      return
    end
    @client.update(message)
    puts "Tweet tweeted."
  end

  def dm(target, message)
    screen_names = followers_list
    if not screen_names.include? target
      puts "Target not following you"
      return
    end
    puts "Trying to send #{target} this direct message:"
    puts message

    message = "d @#{target} #{message}"
    tweet(message)
  end

  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def everyones_last_tweet
    followers = followers_list.sort
    followers.each do |follower|
      timestamp = @client.user(follower).status.created_at
      timestamp.strftime("%A, %b, %d")
      last_tweet = @client.user(follower).status.text
      puts "#{follower} #{last_tweet} #{timestamp}"
    end
  end

  def shorten(original_url)
    require 'bitly'
    Bitly.use_api_version_3

    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
  end

  def klout_score
    require 'klout'
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'

    friends = @client.friends.collect {|f|}
    friends.each do |friend|
      identity = Klout::Identity.find_by_screen_name(friend)
      user = Klout::User.new(identity.id)
      klout_score = user.score.score
      puts "#{friend} has a klout score of #{klout_score}"
    end
  end

  def spam_my_followers(message)
    followers = followers_list
    followers.each do |follower|
      dm(follower, message)
    end
  end

  def run
    puts "Welcome to my Twitter Client!"
    command = ""
    until command == "quit"
      printf "enter command: "
      command = gets.chomp
      case command
      when "quit" then puts "Goodbye!"
      when /^tweet/ then tweet(command.split[1..-1].join(" "))
      when /^dm/ then dm(command.split[1], command.split[2..-1].join(" "))
      when /^spam/ then spam_my_followers(command.split[1..-1].join(" "))
      when "elt" then everyones_last_tweet
      when /^s/ then puts shorten(command.split[1..-1].join(" "))
      when /^turl/ then tweet(command.split[1..-2].join(" ") + " " + shorten(command.split[-1]))
      else puts "Sorry I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run
