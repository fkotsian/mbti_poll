class TweetPoller < ActiveRecord::Base
  MAX_ATTEMPTS = 3

  attr_accessor :client
  
  def after_initialize
    self.client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['twitter_api_key']
      config.consumer_secret = ENV['twitter_api_secret']
    end

    self.bearer_token = client.bearer_token
    self.save
    # initialize any new client with a bearer_token
    # client
  end
  
  def set_client
    self.client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['twitter_api_key']
      config.consumer_secret = ENV['twitter_api_secret']
    end
  end
  
  def make_request
    num_attempts = 0
    # determine request to make
    res = []
    call = search_for_mbti # does not add them to a result array
    begin
      num_attempts += 1
      call.to_a
      res << call if !call.is_a? 'Twitter::Error' # or .error?
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= MAX_ATTEMPTS
        sleep error.rate_limit.reset_in
        retry
      else
        raise
      end
    end
  end
  
  #search for tweets containing hashtag or words 'MBTI'
  def search_for_mbti
    # search for tweets cotaining #MBTI, #mbti, or 'mbti'
    # save them to DB if the request is valid
    hashtag_res = client.search('#mbti', result_type: 'mixed', count: 100, lang: 'en')
    hashtag_res.take(5).each { |tweet| puts "#{tweet.user.screen_name}: #{tweet.text}" }
    save_tweets_to_db(hashtag_res)
    # text_res = client.search('mbti', result_type: 'mixed', count: 100, lang: 'en')
    # text_res.take(5).each { |tweet| puts "#{tweet.user.screen_name}: #{tweet.text}" }

    #save tweets to DB and save last_tweet_id as max_id so can poll later
    # self.last_tweet_id = hashtag_res.first.id.to_s # || Tweet.last.t_id_str
  end
  
  def save_tweets_to_db(tweets)
    tweets.each do |tweet|
      user = tweet.user
      Tweet.create(
        t_id_str: tweet.id.to_s,
        created_at: tweet.created_at,
        text: tweet.text,
        retweet_count: tweet.retweet_count,
        retweeted: tweet.retweeted?,
        user_id_str: user.id.to_s,
        user_name: user.screen_name,
        user_location: user.location,
        user_statuses_count: user.statuses_count,
        user_followers_count: user.followers_count,
        user_friends_count: user.friends_count,
        stored_at: Time.now
      )
    end
  end
  
  # search for tweets containing hashtag or word '/type/' (e.g., 'ENTP')
  def search_for_type(type)
    q = type
    # search for tweets containing type or #type
    # save them to DB if request is valid (ie not an exception)
  end
  
end
