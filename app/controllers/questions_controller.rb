require "json"
require "open-uri"

class QuestionsController < ApplicationController
  def show
    @occasion = Occasion.find_by(id: params[:occasion_id])
    @show_gift = true
    if @occasion
      @question = @occasion.question
      @answer = @question.answer
    else
      redirect_to root_path, alert: "Occasion not found."
    end
  end

  def edit
    @occasion = Occasion.find(params[:occasion_id])
    @answer = Answer.find_by(user: current_user, occasion: @occasion) #load the previous answer
    @question = @occasion.question
    @gift = Gift.find(@occasion.gift)

    @movies = [
      "",
      "Action", "Adventure", "Animation", "Comedy", "Crime",
      "Documentary", "Drama", "Family", "Fantasy", "Horror",
      "Mystery", "Romance", "Sci-Fi", "Thriller", "War",
    ]

    @music = [
      "",
      "Blues", "Classical", "Country", "Disco", "Electronic",
      "Folk", "Funk", "Hip Hop", "House", "Indie",
      "Jazz", "Metal", "Pop", "Punk", "R&B",
      "Reggae", "Rock", "Soul", "Techno",
    ]

    @books = [
      "",
      "Biography", "Children's", "Contemporary Fiction", "Crime", "Fantasy",
      "Historical Fiction", "Horror", "Mystery", "Non-Fiction", "Poetry",
      "Romance", "Science Fiction", "Self-Help", "Thriller", "Young Adult",
    ]

    @hobbies = [
      "",
      "Board Games", "Cooking", "Crafting", "Cycling", "Drawing", "Fishing",
      "Gardening", "Hiking", "Painting", "Photography", "Playing Musical Instruments",
      "Reading", "Running", "Traveling", "Yoga",
    ]

    @brands = [
      "",
      "Adidas", "Amazon", "Apple", "Coca-Cola", "Gap",
      "H&M", "Levi's", "McDonald's", "Nike", "Puma",
      "Sony", "Starbucks", "Samsung", "Target", "Toyota",
    ]

    @places = [
      "",
      "Amusement Park", "Beach", "Botanical Garden", "City Park", "Cave",
      "Countryside", "Desert", "Historical Site", "Island", "Lake",
      "Mountain", "National Park", "Rainforest", "Ski Resort", "Waterfall",
    ]

    @purchases = [
      "",
      "Backpack", "Binoculars", "Bookmarks", "Camping Stove", "Camping Tent",
      "Climbing Gear", "Cooking Equipment", "E-books", "Hiking Boots", "Headlamp",
      "Map and Compass", "Outdoor Clothing", "Paperback Novels", "Travel Guides", "Water Bottles",
    ]

    @restaurant = [
      "",
      "American (Burgers)", "Brazilian", "Chinese", "French", "Greek",
      "Indian", "Italian", "Japanese", "Korean", "Mediterranean",
      "Mexican", "Middle Eastern", "Spanish", "Thai", "Vietnamese",
    ]

    @devices = [
      "",
      "Amazon Echo", "Apple Watch", "Canon EOS Camera", "DJI Mavic Drone", "Fitbit",
      "iPad", "iPhone", "MacBook", "Nintendo Switch", "PlayStation",
      "Samsung Galaxy S Series", "Smart TV", "Windows Laptop", "Xbox", "GoPro Camera",
    ]

    @games = [
      "",
      "Adventure", "Arcade", "Educational", "Fighting", "First-Person Shooter (FPS)",
      "Horror", "Music/Rhythm", "Platformer", "Puzzle", "Racing",
      "Role-Playing Game (RPG)", "Simulation", "Sports", "Strategy",
    ]
  end

  def new
    @occasion = Occasion.find(params[:occasion_id])
    @question = @occasion.question
  end

  def update
    @question = Question.find(params[:id])
    @answer = Answer.find_by(user: current_user, occasion: @question.occasion)
    #instead of making new form every time this update the form to previous answers.
    if @answer == nil
      @answer = Answer.new(param_strong)
    end
    @answer.user = current_user
    @occasion = Occasion.find(@question.occasion_id)
    # update status in occasion questionnaire is done
    @answer.occasion = @occasion
    @occasion.status = true
    @occasion.save!

    @answer_values = params[:question].values
    @without_pledge = @answer_values.delete_at(0)

    @answer.pledge_amount = params[:question][:pledge_amount]
    @answer.hobbies = params[:question][:hobbies]
    @answer.movies = params[:question][:movies]
    @answer.music = params[:question][:music]
    @answer.books = params[:question][:books]
    @answer.brands = [params[:question][:brands]]
    @answer.places = [params[:question][:places]]
    @answer.games = [params[:question][:games]]
    @answer.restaurant = params[:question][:restaurant]
    @answer.devices = [params[:question][:devices]]
    @answer.purchases = [params[:question][:purchases]]

    if @answer.save
      @answers = @answer_values.select { |a| a.size > 1 }

      # @scraped_products = gift_scraper(@answers)
     @scraped_products = backup_scrapper(@answers)

      # if @scraped_products.empty?
      #   @scraped_products = backup_scrapper(@answers)
      # end

      proposal = Proposal.find_or_create_by(occasion: @occasion, myoccasion: @occasion.myoccasion)
      @scraped_products.each do |product_data|
        product = Product.new(
          title: product_data[:name],
          price: product_data[:price],
          url: product_data[:image_url],
          proposal: proposal,
        )
        product.save
      end
      redirect_to root_path, notice: "Questionnaire is answered."
    else
      render :new, alert: :unprocessable_entity
    end
  end

  def questionnaire
    @question = Question.find(params[:id])
    @questions = Question.all
  end

  private

  def param_strong
    params.require(:question).permit(:music, :hobbies, :movie, :brands, :books, :restaurant, :games, :places, :devices, :purchases, :occasion_id, :user_id, :recipient, :myoccasion, :gift)
  end


  def gift_scraper(answer_values)
    scraped_products = []
    answer_values.each do |answer|
      encoded_answer = answer.gsub(" ", "%20")
      url = "https://api.bestbuy.com/v1/products((search=#{answer[0]}))?apiKey=TEaoEZmvBDYZWr2hHVcHOZHY&sort=regularPrice.asc&show=regularPrice,shortDescription,name,image,thumbnailImage&pageSize=5&format=json"
      url_serialized = URI.open(url).read
      results = JSON.parse(url_serialized)
    #   File.open("results_#{Date.today}_#{ans}.json", "w") do |f|
    #   f.write(results.to_json)
    # end
      if results["total"] > 0
        p result = results["products"].first
        if regularPrice <= @occasion.answer.pledge_amount
          scraped_products << {
            name: result["name"],
            price: result["regularPrice"],
            image_url: result["image"]
          }
        else
          "No products found"
        end
      end
    end
    scraped_products.uniq.compact
  end



  def backup_scrapper(answer_values)
    scraped_products = []
    answer_values.each do |answer|
      filepath = "#{answer}.json"
      serialized_beatles = File.read(filepath)
      results = JSON.parse(serialized_beatles)
      if results["total"] > 0
          result = results["products"].first
        if result["regularPrice"].to_f <= @occasion.answer.pledge_amount
          scraped_products << {
            name: result["name"],
            price: result["regularPrice"],
            image_url: result["image"]
          }
        else
          "No products found"
        end
      end
    end
    scraped_products.uniq.compact
  end

end
