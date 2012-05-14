# coding: utf-8
class TopController < ApplicationController
  
  HASH_TAG = "#ishikitakai"
  MASTER_ID = ENV['MASTER_ID']
  MEMBERS = ENV['MEMBERS']

  #-------#
  # index #
  #-------#
  def index
    @tweet = Tweet.new
    @hash_tag = HASH_TAG
    @str_count = @hash_tag.length + 1
    @members = MEMBERS.split(",")
  end

  #--------#
  # create #
  #--------#
  def create
    tweet = Tweet.new( params[:tweet] )
    tweet_text = "#{tweet.post} #{HASH_TAG}"
    
    master_user = User.where( uid: MASTER_ID ).first
    
    ActiveRecord::Base.transaction do
      # Twitterポスト
      Twitter.configure do |config|
        config.consumer_key       = ENV['TWITTER_KEY']
        config.consumer_secret    = ENV['TWITTER_SECRET']
        config.oauth_token        = master_user.token
        config.oauth_token_secret = master_user.secret
      end

      # Twitterクライアント生成
      twitter_client = Twitter::Client.new
      
      # 投稿ポスト
      twitter_client.update( tweet_text )
    end
    
    redirect_to( { action: "index" }, notice: "投稿が完了しました。" ) and return
  rescue => ex
    flash[:notice] = ""
    flash[:alert] = ex.message
    
    @tweet = Tweet.new
    @hash_tag = HASH_TAG
    @str_count = @hash_tag.length + 1
    
    render action: "index" and return
  end
  
end
