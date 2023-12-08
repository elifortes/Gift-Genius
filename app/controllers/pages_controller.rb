class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    return unless current_user
    # looking for events i created
    @myoccasions = current_user.myoccasions
    # looking for product i choose for an existing event.
    @occasions = current_user.occasions
    @ids_to_reject = @myoccasions.map { |myoccasion| myoccasion.id }
    @occasions = @occasions.map { |occasion| occasion unless @ids_to_reject.member?(occasion.myoccasion_id) }
    @occasions.compact!
  end
end
