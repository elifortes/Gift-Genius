require 'net/http'
require 'dotenv/load'

class QuestionsController < ApplicationController
  before_action :fetch_categories, only: [:show, :new]

  def index
    @questions = Question.all

  end
  def show
    @questions = Question.all
  end

  def new
  end

  def create
    selected_category_id = params[:selected_category_id]
    uri = URI("https://api.bestbuy.com/v1/products(categoryId=#{selected_category_id})")
    params = {
      apiKey: ENV.fetch('BESTBUY_API_KEY'),
      format: 'json',
      pageSize: 10
    }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    # puts "API Response Status Code: #{response.code}"

    if response.is_a?(Net::HTTPSuccess)
      @products = JSON.parse(response.body)["products"]
    else
      @products = []
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  private

  def fetch_categories
    uri = URI('https://api.bestbuy.com/v1/categories')
    params = {
      apiKey: ENV.fetch('BESTBUY_API_KEY'),
      format: 'json',

    }
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      @categories = JSON.parse(response.body)["categories"]
    else
      @categories = []
    end
  end
end
