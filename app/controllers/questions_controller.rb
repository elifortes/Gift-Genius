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
    raise
  end

  def update
    @question = Question.find(params[:id])

    # check if there is a favorite [occasion.question -> occasion.favorite]
    #       if exist? -> favorite[merge/update]
    # <<<<<<< HEAD
    # creating a new favorite
    # @answer = Answer.new(music: params[:question][:music], hobbies: params[:question][:hobbies],
    # games: params[:question][:games])
    # =======
    # # creating a new favorite
    # @answer = Answer.new(music: params[:question][:music], hobbies: params[:question][:hobbies],
    #                       games: params[:question][:games], movies: params[:question][:movies],
    #                         books: params[:question][:books],restaurant: params[:question][:restaurant],
    #                           brands: params[:question][:brands],devices: params[:question][:devices],
    #                             places: params[:question][:places],purchases: params[:question][:purchases])

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
    # raise
    # @answer_values.each do |value|
    #   if value == ""
    #     redirect_to edit_occasion_question_path(@occasion, @question), alert: "Please answer all questions."
    #     return
    #   end
    # end
    if @answer.save
      # raise
      scraped_products = gift_scrapper
      proposal = Proposal.find_or_create_by(occasion: @occasion, myoccasion: @occasion.myoccasion)
      scraped_products.each do |product_data|
        product = Product.new(
          title: product_data[:name],
          price: product_data[:price],
          url: product_data[:image_url] + ".jpg",
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

  def gift_scrapper
    require "open-uri"
    require "nokogiri"
    # answers = ["Cooking", "Animation", "Disco", "Contemporary Fiction", "Nike", "Cave", "Fighting", "French", "Canon EOS Camera", "Bookmarks"]
    scraped_products = []
    @answer_values.each do |answer|
      url = "https://www.amazon.com.au/s?k=#{answer.gsub(" ", "+")}+for+adult&s=date-desc-rank&crid=1NPJG8DRL1OB5&qid=1701761808&sprefix=binoculars+for+adult%2Caps%2C263&ref=sr_st_date-desc-rank&ds=v1%3AXl0ZP7a2L%2Ff5BvRu%2FhDncNXfklqFiyXzl7pUoG6zS0A"
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML(html_file)
      first_product_name_element = html_doc.css("h2").first
      first_product_name = first_product_name_element ? first_product_name_element.content.strip : "Not found"
      first_product_price_element = html_doc.css("span.a-price-whole").first
      first_product_price = first_product_price_element ? first_product_price_element.content.strip : "Not found"
      first_product_image_element = html_doc.css("div.a-section.aok-relative.s-image-square-aspect img").first
      first_product_image_url = first_product_image_element ? first_product_image_element["src"] : "Not found"
      scraped_products << {
        name: first_product_name,
        price: first_product_price,
        image_url: first_product_image_url,
      }
    end
    scraped_products
  end

  # def merge_array
  #   @myoccasion = Myoccasion.find(:myoccasion_id)
  #   @x = []
  #   @myoccasion.occasions.each do |occasion|
  #     @y = occasion.question.values
  #     @y.delete_at(0)
  #     @x = (@y.concat(@x)).reject(&:empty?).uniq
  #   end
  #   return @x
  # @y = @y.flatten
  # @x = @y.delete_at(0)
  # end
  # @answers_for_occasion = Answer.where(occasion_id: @occasion)
  # @y = @answers_for_occasion.map do |answer|
  #   answer =  params[:question].values
  #   answer
end
