class ProductsController < ApplicationController
  def index
    @products = Product.rank(:row_order).all
  end

  def sort
    @product = Product.find(params[:id])
    @product.update(row_order_position: params[:row_order_position])
    head :no_content
  end

  def show

    # am i the creator of the occasion
    @product = Product.find(params[:proposal_id])
    @proposal = Proposal.find(params[:id])
    @myoccasion = Myoccasion.find(@proposal.myoccasion_id)
    @gift = Gift.find(@myoccasion.gift)

    @owner_id = @myoccasion.user_id
    # am i the creator of the occasion
    @ownership = (@owner_id == current_user.id)
    # show the stuff now
    @recipient_id = @product.proposal.occasion.recipient
    @recipient = User.find(@recipient_id).personnal
    @sex = @recipient.info["sex"]
    @birthday = @recipient.birthday
    @name = @recipient.name
    @party = @gift.title
    @profile = @recipient.info["profile"]

    if !@product.info || rand <= 0.25
      @suggestion = "I have this gift: #{@product.title}, costing #{@product.price.to_f} for my friend's #{@name},a #{@sex} the birthday is on #{@birthday}, and the occasion is #{@party}, and I need help choosing the most suitable one.  We know that as  #{@profile}, tell me if its a good choice for present, keep simple, no much text, max 150 letters."

      client = OpenAI::Client.new
      client.add_headers("OpenAI-Beta" => "assistants=v1")
      chaptgpt_response = client.chat(parameters: {
                                        model: "gpt-3.5-turbo",
                                        messages: [{ role: "user", content: @suggestion }],
                                      })
      @content = chaptgpt_response["choices"][0]["message"]["content"]
      @product.info = @content
      @product.save!
    end
  end

  def update
    @product = Product.update(params_strong)
  end

  private

  def params_strong
    params.require(:product).permit(:title, :description, :proposal_id, :position, :url, :selected, :price, :rating, :row_order)
  end
end
