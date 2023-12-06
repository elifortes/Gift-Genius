# gifts_categories = [
#   {
#       "id": 1,
#       "name": "Movies",
#       "categories": [
#           "pcmcat1680806209177" # bluray tv shows
#       ]
#   },
#   {
#       "id": 2,
#       "name": "Electronics"
#       "categories": [
#           "abcat0500000", # Computers and Tablets
#           "pcmcat1586900952752", # Xbox
#       ]
#   }
# ]

# When the person gets to the /questions page
# it asks the question: "what is that the person likes?"
# it will list the options available on "gifts_categories" variable/database

# what is that the person likes?
#   - Movies
#   - Electronics

# when the user clicks in one of the options
# say the person selects "Electronics" the controller will search the BestBuy API for products
# from categories "abcat0500000" "pcmcat1586900952752" and show the list of the products retrieved

# the person then needs to click on a product name to select

# click submit to save the questionnaire answers

# questionnaire data will look like:
# id: identify on db the answer
# group_id:
# user_id: who filled the questionnaire
# category_id: gifts_categories
# product_id: product selected (sku)
