class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  # def home
  #   if current_user
  #   @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
  #   @mycontacts.sort_by! { |p| p.personnal.birthday }
  #   end
  # end
end
