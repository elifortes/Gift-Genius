class MycontactsController < ApplicationController
  def update
    @mycontact = current_user.mycontact
    @mycontact.contacts = params[:mycontact][:contacts]
    @mycontact.contacts.delete(0)
    @mycontact.contacts.compact!
    if @mycontact.save!
      redirect_to new_myoccasion_path
    end
  end

  private

  def params_strong
    params.require(:mycontact).permit(:contacts, :user_id)
  end
end
