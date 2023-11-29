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

# Proposal.create(title: 'First Proposal', description: 'This is the first proposal.', user: User.first)
# Proposal.create(title: 'Second Proposal', description: 'This is the second proposal.', user: User.first)
# Proposal.create(title: 'Third Proposal', description: 'This is the second proposal.', user: User.first)
def users

  if User.all.count < 10
    10.times do |i|
      user = User.new(email:"user0#{i}@gmail.com")
      user.password = "123456"
      personnal = Personnal.new(
        name: Faker::Name.name,
        birthday:Faker::Date.birthday)
       user.personnal = personnal
       contact = Contact.new
       contact.user = user
       contact.save!
       user.contact = contact
      p user.save!
    end
  end
end
User.destroy_all

# userM = User.create!(email: 'mena@gmail.com',password: 'aaaaaa')
#  userM.personnal = Personnal.new(name: 'Menahil',birthday:Date.new(1994,01,1))
#  userM.save!
# userU = User.create!(email: 'nak@me.com',password: 'kalvin')
# userU.personnal = Personnal.new(name: 'Francois',birthday:Date.new(1971,01,14))
# contact = Contact.new
# contact.user = userU
# p contact.save!
# p contact
# userU.contact = Contact.new()
# p userU
# p userU.save!
# users

def user_contacts(userE)
  5.times do
  array = []
  user_contact = UserContact.new
  user_contact.user = userE
  contact = Contact.all.sample
  if contact.user_id != userE.id || array.include?(contact.id)
    user_contact.contact = contact
    array.push(contact.id)
    user_contact.save!
  end
  end
end
UserContact.destroy_all
user_contacts(userE)

GroupMember.destroy_all

p gift = GiftSpec.new
p gift.save!

occasion = Occasion.new(occasion_name:'ThisIsMyEvent')
occasion.user = userU
occasion.user_contact = userU.user_contacts.sample
occasion.gift_spec = gift
p occasion
p occasion.save!

userU.user_contacts.each do |c|
  group_member = GroupMember.new
  group_member.occasion = occasion
  group_member.user_contact = c
  p group_member
  p group_member.save!
end

# recipient for the occasion.
#
