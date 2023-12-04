class QuestionsController < ApplicationController
  def show
    @occasion = Occasion.find_by(id: params[:occasion_id])
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

    @answer.pledge_amount = params[:question][:pledge_amount]
    @answer.hobbies = params[:question][:hobbies]
    @answer.movies = params[:question][:movies]
    @answer.music = params[:question][:music]
    @answer.books = params[:question][:books]
    @answer.brands = [params[:question][:brands]]
    @answer.places = [params[:question][:places]]
    @answer.games =[ params[:question][:games]]
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
      # @answer_values.save
      redirect_to occasion_path(@occasion, answer: @answer.id), notice: "Questionnaire is answered."
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
end

# def index
#   @questions = Question.all
# end

# def show
#   @question = Question.all

# end

# def new
#   @question = Question.new
# end

# def create
#   @question = Question.new(question_params)
#   if @question.save!

#   redirect_to myoccasions_path
#   else
#     render :new
# end
# end

# private

# def question_params
#   params.require(:question).permit(:content)
# end

# end
