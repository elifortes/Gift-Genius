# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Proposal.create(title: 'First Proposal', description: 'This is the first proposal')
Proposal.create(title: 'Second Proposal', description: 'This is the second proposal')

def users
  if User.all.count < 10
    10.times do |i|
      user = User.new(email:"user0#{i}@gmail.com")
      user.password = "123456"
      personnal = Personnal.new(
        name: Faker::Name.name,
        birthday:Faker::Date.birthday)
       user.personnal = personnal
      p user.save!
    end
  end
end
User.destroy_all
user = User.create!(email: 'nak@me.com',password: 'kalvin')
user.personnal = Personnal.new(name: 'Francois',birthday:Date.new(01/14/1971))
user.save!
users

def contacts
  20.times do
  User.all.each do |u|
    if rand < 0.5
      contact = Contact.new
      contact.user = u
      contact.contact_id = User.all.sample.id
      p contact.save!
    end
  end
end
end
Contact.destroy_all
contacts
