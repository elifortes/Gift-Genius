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
    @product = Product.find(params[:proposal_id])
    @proposal = Proposal.find(params[:id])
    #condition 1: @product.proposal.occasion.answer
    @recipient_id = @product.proposal.occasion.recipient
    @recipient = User.find(@recipient_id).personnal.to_json
    @gift = Product.all.last.title.to_json

    @personnal = current_user.personnal

    if @product.info
      @suggestion = "Hello, we have this a gift#{@gift} ,for this person #{@recipient}, do you think he/she will love it, can you rate on the scale from 1 to 10 ? "

      # "Hello, we have this a gift#{@gift} ,for this person #{@recipient}, do you think he/she will love it, can you rate on the scale from 1 to 10 ?

      if !@product.info
        @suggestion = "We are creating a occasion for to give a gift #{@gift}, for this person #{@recipient}, based on this information #{@sex}, #{@picture} and #{@profile}, rate the scale from 1 to 10
      and tell me if matches the info I gave to you, please"

        client = OpenAI::Client.new
        client.add_headers("OpenAI-Beta" => "assistants=v1")
        chaptgpt_response = client.chat(parameters: {
                                          model: "gpt-3.5-turbo",
                                          messages: [{ role: "user", content: @suggestion }],
                                        })
        @content = chaptgpt_response["choices"][0]["message"]["content"]
        @product.info = { "content#{Date.new}".to_s => @content }
        @product.save!
      end
    end
  end

  # personnal = Personnal.new(
  #   name: Faker::Name.name,
  #   birthday: Faker::Date.birthday,
  #   info: { sex: "man", picture: "man/man-0#{i}.jpg", profile: man.sample },
  # )

  # "Give me a simple recipe for #{name} with the ingredients #{ingredients}. Give me only the text of the recipe, without any of your own answer like 'Here is a simple recipe'."}]
  # })

  def update
    @product = Product.update(params_strong)
  end

  private

  def params_strong
    params.require(:product).permit(:title, :description, :proposal_id, :position, :url, :selected, :price, :rating, :row_order)
  end
end
