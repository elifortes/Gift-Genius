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
# clean database
Gift.destroy_all
GroupMember.destroy_all
UserContact.destroy_all
Contact.destroy_all
Occasion.destroy_all
User.destroy_all

# creating 30 users for login with userxx@me.com
def users
    30.times do |i|
      user = User.new(email:"user#{i}@gmail.com")
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

      user.personnal = personnal
      user.personnal = personnal
      contact = Contact.new
      contact.user = user
      contact.save!
      user.contact = contact
      print i,user.save!

    end
end

User.destroy_all

# userM = User.create!(email: 'mena@gmail.com',password: 'aaaaaa')
#  userM.personnal = Personnal.new(name: 'Menahil',birthday:Date.new(1994,01,1))
#  userM.save!
#   users
# userU = User.create!(email: 'nak@me.com',password: 'kalvin')
# userU.personnal = Personnal.new(name: 'Francois',birthday:Date.new(1971,01,14))
# contact = Contact.new
# # contact.user = userU
# p contact.save!
# p contact
# userU.contact = Contact.new()
# p userU
# p userU.save!
# user

userM = User.create!(email: 'mena@gmail.com',password: 'aaaaaa')
userM.personnal = Personnal.new(name: 'Menahil',birthday:Date.new(1994,01,1))
userM.save!
users

# need to be redone...

def contacts
  User.all.each do |u|
  end
end


def user_contacts(userM)
  5.times do
  array = []

    user_contact = UserContact.new
    user_contact.user = userM
    contact = Contact.all.sample
    if contact.user_id != userM.id || array.include?(contact.id)
      user_contact.contact = contact
      array.push(contact.id)
      user_contact.save!
    end
  end
end
UserContact.destroy_all
user_contacts(userM)



users

array = []
User.all.each do |u|

  if rand < 0.5
   array << u.id
  end
end
p array


userU = User.create!(email: 'nak@me.com',password: 'kalvin')
userU.personnal = Personnal.new(name: 'Francois',birthday:Date.new(1971,01,14))
print userU, userU.save!
userM = User.create!(email: 'mena@gmail.com',password: 'aaaaaa')
userM.personnal = Personnal.new(name: 'Menahil',birthday:Date.new(1994,01,1))
userM.save!


p gift = GiftSpec.new
p gift.save!

occasion = Occasion.new(occasion_name:'ThisIsMyEvent')
occasion.user = userM
occasion.user_contact = userM.user_contacts.sample
occasion.gift_spec = gift
p occasion
p occasion.save!

userM.user_contacts.each do |c|
  group_member = GroupMember.new
  group_member.occasion = occasion
  group_member.user_contact = c
  p group_member
  p group_member.save!
end

# require 'faker'

# Proposal.create(title: 'First Proposal', description: 'This is the first proposal')
# Proposal.create(title: 'Second Proposal', description: 'This is the second proposal')

# def create_users
#   if User.count < 10
#     10.times do
#       user = User.new(email: Faker::Internet.email, password: '123456')
#       user.build_personal(
#         name: Faker::Name.name,
#         birthday: Faker::Date.birthday
#       )
#       user.save!
#     end
#   end
# end

# User.destroy_all
# userU = User.create!(email: 'nak@me.com', password: 'kalvin')
# userU.build_personal(name: 'Francois', birthday: Date.new(1971, 01, 14))
# userU.save!
# create_users

# userM = User.create!(email: 'mena@gmail.com', password: 'aaaaaa')
# userM.build_personal(name: 'Menahil', birthday: Date.new(1994, 01, 1))
# userM.save!
# create_users

# def create_contacts
#   User.all.each do |u|
#     array = []
#     30.times do
#       next if rand < 0.5

#       contact = Contact.new(user: u)
#       contact.contact = User.find(remaining_user_ids.sample)

#       if contact.contact.present?
#         array << contact.contact.id
#       contact.save!
#       end
#     end
#   end
# end

# Contact.destroy_all
# create_contacts

# gift = GiftSpec.create!

# occasion = Occasion.create(group_name: 'myevent', gift_spec: gift, recipient: User.first.contacts.sample)

# 10.times do
#   first_user = User.first
#   random_contact = first_user.contacts.sample

#   group = Group.new(occasion: occasion, contact: random_contact)
#   group.save!
#   p group
# end

# recipient for the occasion.
#

mycontacts = Mycontact.new
mycontacts.user = userU
mycontacts.contacts = array
p mycontacts.save!
contacts = Mycontact.new
contacts.user = userM
contacts.contacts = array
p contacts.save!
