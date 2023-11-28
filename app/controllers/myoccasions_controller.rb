class MyoccasionsController < ApplicationController
  def new
    @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    @mycontacts =  @mycontacts.map { |c| c.personnal }
    #@mycontacts.sort_by! { |p| p.personnal.birthday }
    @myoccasion = Myoccasion.new
  end

  def create
    @myoccasion = Myoccasion.new(param_strong)
    @myoccasion.groups = params[:myoccasion][:groups].map { |arr| arr.to_i }
    @myoccasion.user = current_user

    if @myoccasion.save!
      redirect_to groups_gift_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def param_strong
    params.require(:myoccasion).permit(:groups, :user)
  end

  def getmyoccasion
    @list = List.find(params[:id])
  end
end
