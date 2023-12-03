# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "faker"

# clean database
Gift.destroy_all
UserContact.destroy_all
Myoccasion.destroy_all
Occasion.destroy_all
Question.destroy_all
Answer.destroy_all
User.destroy_all
# creating userlogin for mains
userU = User.create!(email: "nak@me.com", password: "kalvin")
userU.personnal = Personnal.new(name: "Francois", birthday: Date.new(1971, 01, 14))
print userU, userU.save!

userM = User.create!(email: "mena@gmail.com", password: "aaaaaa")
userM.personnal = Personnal.new(name: "Menahil", birthday: Date.new(1994, 01, 1))
userM.save!

userE = User.create!(email: "elimrfortes@gmail.com", password: "blabla")
userE.personnal = Personnal.new(name: "Eli", birthday: Date.new(1992, 01, 1))
userE.save!

# creating 30 users for login with userxx@me.com
def users
  30.times do |i|
    user = User.new(email: "user#{i}@gmail.com")
    user.password = "123456"
    personnal = Personnal.new(
      name: Faker::Name.name,
      birthday: Faker::Date.birthday,
    )
    user.personnal = personnal
    print i, user.save!
  end
end

users

# creating a contacts group from User.all
array = []
User.all.each do |u|
  if rand < 0.5
    array << u.id
  end
end

# assign the contacts to main
#array << userU.id
#array << userM.id
#array << userE.id

p array

mycontacts = Mycontact.new
mycontacts.user = userU
mycontacts.contacts = array
p mycontacts.save!

array << userM.id
contacts = Mycontact.new
contacts.user = userM
contacts.contacts = array
p contacts.save!

contacts = Mycontact.new
contacts.user = userE
contacts.contacts = array
p contacts.save!

def occasion(user, array, user1, user2)
  myoccasion = Myoccasion.new(
    groups: array.sample(3) << user1.id << user2.id,
    recipient: array.sample,
  )
  gift = Gift.new(
    # price: 100,
    title: ["Anniversary", "Baby_Shower", "Birthday", "Christmas", "Easter",
            "Eid", "Engagement", "Father_s_Day", "Graduation", "Halloween",
            "Housewarming", "Mother_s_Day", "New_Home", "New_Year_s_Eve",
            "Retirement", "Thanksgiving", "Valentine_s_Day", "Wedding"].sample,
  )
  gift.save!
  myoccasion.user = user
  myoccasion.gift = gift.id
  myoccasion.save!

  # create an occasion for each of the group member
  myoccasion.groups.push(user.id).each do |p|
    occasion = Occasion.new(
      recipient: myoccasion.recipient,
      # gift: myoccasion.gift,
      # same gift for all occasions created in the loop

      title: gift.title,
      gift_id: gift.id,
    )
    occasion.myoccasion = myoccasion
    userR = User.find(p)
    occasion.user = user # userR
    occasion.save!


    proposal = Proposal.new
    proposal.occasion = occasion
    proposal.myoccasion = myoccasion
    proposal.user = userR
    proposal.save!
    5.times do |p|
      product = Product.new(title: p, price: rand(1..300))
      product.title = Faker::Commerce.product_name
      product.proposal = proposal
      product.save!
    end

    question = Question.new(
      myoccasion: myoccasion.id,
      recipient: myoccasion.recipient,
      gift: gift.id,
      movies: ["Drama", "Adventure"],
      music: ["Pop", "Indie"],
      books: ["Mystery", "Science Fiction"],
      hobbies: ["Reading", "Photography", "Hiking"],
      activities: ["Cooking", "Traveling"],
      channels: ["Email", "Text Messages"],
      contents: ["Articles", "Videos"],
      brands: ["Nike", "Apple"],
      places: ["Beach", "Mountain"],
      socials: ["Twitter", "Instagram"],
      onlines: ["Best hiking trails", "Photography tips"],
      purchases: ["Books", "Outdoor gear"],
      communications: ["Family gatherings", "Friends hangouts"],
      apps: ["Fitness tracker app", "Recipe app"],
      websites: ["National Geographic", "Cooking blogs"],
      locations: ["Visited Paris", "Explored Grand Canyon"],
      devices: ["iPhone", "MacBook"],
      softwares: ["Adobe Lightroom", "Google Chrome"],
      games: ["Adventure", "Puzzle"],
      platforms: ["Nintendo Switch"],
    )
    question.occasion = occasion
    question.user = userR
    question.save!
    p question
  end
end

occasion(userU, array, userM, userE)
occasion(userM, array, userU, userE)
occasion(userE, array, userU, userM)
