class MyoccasionsController < ApplicationController
  def index
    @myoccasions = current_user.myoccasions
    @occasions = current_user.occasions
  end

  def show
    @myoccasion = Myoccasion.find(params[:id])
    
  end

  def confirmation
    @myoccasion = Myoccasion.find(params[:myoccasion_id])
    # @gift = Gift.find(@myoccasion.gift)
    # @recipient = User.find(@myoccasion.recipient)
  end

  def new
    @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    @mycontacts = @mycontacts.map { |c| c.personnal }
    # @mycontacts.sort_by! { |p| p.personnal.birthday }
    @myoccasion = Myoccasion.new
  end

  def create
    @myoccasion = Myoccasion.new(param_strong)
    @myoccasion.groups = params[:myoccasion][:groups].map { |arr| arr.to_i }
    if @myoccasion.groups.include?(params[:myoccasion][:recipient].to_i)
      @myoccasion.groups.delete(params[:myoccasion][:recipient].to_i)
    end
    @myoccasion.user = current_user
    @myoccasion.groups.delete(0)

    if @myoccasion.save!
      redirect_to myoccasion_gift_path(@myoccasion)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def gift
    @myoccasion = Myoccasion.find(params[:myoccasion_id])

    @gift = Gift.new
  end

  private

  def param_strong
    params.require(:myoccasion).permit(:groups, :user, :recipient, :gift, :photo)
  end

  def getmyoccasion
  end
end
