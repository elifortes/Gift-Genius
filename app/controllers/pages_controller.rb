class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # hightlights moments.
    # mycontacts
    # myoccasions
    # occasions

    return unless current_user
    @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    # @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    if current_user.mycontact
      @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    else
      @mycontacts = []
    end
    @mycontacts.sort_by! { |p| p.personnal.birthday }
    @myoccasions = current_user.myoccasions
  end
end
