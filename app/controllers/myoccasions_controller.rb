class MyoccasionsController < ApplicationController
  def index
    @myoccasions = current_user.myoccasions
    @occasions = current_user.occasions
  end

  def show
    @myoccasion = Myoccasion.find(params[:id])
    @show_gift = true
  end

  def confirmation
    @myoccasion = Myoccasion.find(params[:myoccasion_id])
    @occasion = current_user.occasions.select { |o| o.myoccasion_id == @myoccasion.id }
    @occasions = current_user.occasions
  end

  def new
    unless current_user.mycontact.contacts.nil?
      @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) unless c.nil? }
    else
      @mycontacts = []
    end
    @mycontacts.compact!
    @mycontacts = @mycontacts.map { |c| c.personnal unless c.nil? }
    # @mycontacts.sort_by! { |p| p.personnal.birthday }
    @myoccasion = Myoccasion.new
    @mycontact = current_user.mycontact
    @users = User.all.map { |u| u.personnal unless u.nil? }
  end

  def create
    @myoccasion = Myoccasion.new(param_strong)
    @myoccasion.groups = params[:myoccasion][:groups].map { |arr| arr.to_i }
    if @myoccasion.groups.include?(params[:myoccasion][:recipient].to_i)
      @myoccasion.groups.delete(params[:myoccasion][:recipient].to_i)
    end
    @myoccasion.user = current_user
    @myoccasion.groups.delete(0)
    @myoccasion.groups.uniq!

    if @myoccasion.save!
      redirect_to myoccasion_gift_path(@myoccasion)
    else
      render :new, status: :unprocessable_entity
    end

    # new_user_added = true
    # if new_user_added
    #   flash[:new_user_added] = true
    # end

  end

  def gift
    @myoccasion = Myoccasion.find(params[:myoccasion_id])
    @gift = Gift.new
  end

  private

  def param_strong
    params.require(:myoccasion).permit(:groups, :user, :recipient, :gift, :photo)
  end

  def myoccasion_to_occasion
  end
end
