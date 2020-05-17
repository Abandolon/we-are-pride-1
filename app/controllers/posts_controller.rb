class PostsController < ApplicationController
  require 'net/http'
  require 'json'
  require 'open-uri'
  require 'net/https'

  def create
    post = Post.new(
      prompt: params[:prompt],
      message: params[:message]
    )

    uri = URI('https://obscure-anchorage-52573.herokuapp.com/post')
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = post.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end

  end

  def index
    # Post.destroy_all
    # parse_results
    @posts = Post.all
  end

  private

  def parse_results
    url = "https://obscure-anchorage-52573.herokuapp.com/posts"
    posts = open(url).read
    JSON.parse(posts).each do |post|
      Post.create(
        prompt: post['prompt'],
        message: post['message'],
        timestamp: post['timestamp']
      )
    end
  end
end
