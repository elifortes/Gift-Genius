class ApiService
  # Your class implementation here
end

# install gem
# gem 'httparty'

# class TasteDiveService
#   include HTTParty
#   base_uri 'https://tastedive.com/api/similar'

#   def self.get_recommendations(query)
#     api_key = 'YOUR_TASTEDIVE_API_KEY'
#     options = { query: { k: api_key, q: query, type: 'suggestions', info: 1 } }
#     response = get('', options)
#     JSON.parse(response.body)['Similar']['Results']
#   end
# end



# # app/controllers/gifts_controller.rb
# class GiftsController < ApplicationController
#   def suggest_gifts
#     # Collect user answers from the form
#     user_answers = params[:user_answers]

#     # Extract relevant information for TasteDive API query
#     query = "#{user_answers[:favorite_books]}, #{user_answers[:favorite_movies]}"

#     # Get recommendations from TasteDive
#     @gift_suggestions = TasteDiveService.get_recommendations(query).first(5)
#   end
# end


# <!-- app/views/gifts/suggest_gifts.html.erb -->
# <h1>Gift Suggestions</h1>

# <% if @gift_suggestions.present? %>
#   <ul>
#     <% @gift_suggestions.each do |suggestion| %>
#       <li><%= suggestion['Name'] %></li>
#     <% end %>
#   </ul>
# <% else %>
#   <p>No gift suggestions found.</p>
# <% end %>
