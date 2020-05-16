class PostsController < ApplicationController
  require 'net/http'
  require 'json'
  require 'open-uri'

  def create
    binding.pry
  end

  def index
    Post.destroy_all
    parse_results
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
