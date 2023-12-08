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
    @profile = @personnal.info[:profile]

    if @product.info
      @suggestion = "have a list of gifts #{@gift} for my friend's #{@recipient} and the occasion #{@occasion}, and I need help choosing the most suitable one.
      Is an #{@profile}, tell me if its a good choice for present, pls"

      client = OpenAI::Client.new
      client.add_headers("OpenAI-Beta" => "assistants=v1")
      chaptgpt_response = client.chat(parameters: {
                                        model: "gpt-3.5-turbo",
                                        messages: [{ role: "user", content: @suggestion }]
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
