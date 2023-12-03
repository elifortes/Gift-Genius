class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # hightlights moments.
    # mycontacts
    # myoccasions
    # occasions


    return unless current_user
    # looking for events i created
    @myoccasions = current_user.myoccasions
    @myoccasion = @myoccasions.first
    # all information about this group
    @groups = @myoccasion.groups.map { |user_id| User.includes(:personnal).find(user_id) }
    @recipient = User.includes(:personnal).find(@myoccasion.recipient)
    @gift = Gift.find(@myoccasion.gift)
    # looking for product i choose for an existing event.
    @occasions = current_user.occasions
    @occasion = @occasion.first
    @proposal = @occasion.proposal
    @products = @proposal.products.where(position: 1)

    # old code
    @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    # @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    if current_user.mycontact
      @mycontacts = current_user.mycontact.contacts.map { |c| User.find(c) }
    else
      @mycontacts = []
    end
    @mycontacts.sort_by! { |p| p.personnal.birthday }
  end


end
