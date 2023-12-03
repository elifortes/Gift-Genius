class GiftsController < ApplicationController
  def create
    @gift = Gift.new(param_strong)
    @myoccasion = Myoccasion.find(params[:myoccasion_id])
    @myoccasion.gift = @gift.id
    @myoccasion.save!
    # @max_price = 1000
    # @min_price = 0
    # @gift.price = (params[:gift][:price].to_f / 100 * 1000).to_i
    if @gift.save!
      @myoccasion.gift = @gift.id

      @myoccasion.save!

      if !@myoccasion.groups.include?(current_user.id) then
        @myoccasion.groups.push(current_user.id)
        @myoccasion.save!
      end
      @myoccasion.groups.each do |o|
          user = User.find(o)
          occasion = Occasion.new(
            recipient: @myoccasion.recipient,
            gift: @gift.id
          )
          occasion.myoccasion = @myoccasion
          occasion.user = user
          occasion.save!
          question = Question.new
          question.user = user
          question.occasion = occasion
          question.save!

      end

      redirect_to myoccasion_confirmation_path(@myoccasion)
    else
      render :new, alert: :unprocessable_entity
    end
  end

  private

  def param_strong
    params.require(:gift).permit(:title, :description, :price, :price_range, :occasion, :photo)
  end
end
