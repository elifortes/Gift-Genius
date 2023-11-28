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
userU = User.create!(email: 'nak@me.com',password: 'kalvin')
userU.personnal = Personnal.new(name: 'Francois',birthday:Date.new(1971,01,14))
userU.save!
users

# need to be redone...

def contacts
  User.all.each do |u|
    array = []
    30.times do
    if rand < 0.5
      contact = Contact.new
      contact.user = u
      userid = User.all.sample.id
      contact.contact_id =userid if contact.contact_id != userid
      if array.include?(userid)
        p 'no'; userid
      else
      p contact.save!
      array.push( userid)
      end
    end
  end
end
end

Contact.destroy_all
contacts


gift = GiftSpec.new
gift.save!

occasion = Occasion.new(group_name:'myevent')
occasion.gift_spec = gift
occasion.recipient = userU.contacts.sample.id
group = Group.new()
group.occasion = occasion
occasion.save!

group = Group.new()
group.occasion = occasion

5.times  do
group = Group.new()
group.occasion = occasion
group.contact_id = userU.contacts.sample.id
group.save!
p group
end
