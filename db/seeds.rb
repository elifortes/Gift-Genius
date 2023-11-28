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
GiftSpec.destroy_all
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
      user.personnal = personnal
      contact = Contact.new
      contact.user = user
      contact.save!
      user.contact = contact
      print i,user.save!
    end
end
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

mycontacts = Mycontact.new
mycontacts.user = userU
mycontacts.contacts = array
print mycontacts
p mycontacts.save!



###### old one
#
def user_contacts(userU)
  array = []
  30.times do |i|
    user_contact = UserContact.new
    user_contact.user = userU
    contact = Contact.all.sample
    if contact.user_id != userU.id && !array.include?(contact.id)
      if rand <= 0.5
        print i, user_contact
        user_contact.contact = contact
        array.push(contact.id)
        print array,contact.id
        user_contact.save!
      end
    end
  end
end


user_contacts(userU)

def occasion(userU)
gift = GiftSpec.new
gift.save!
occasion = Occasion.new(occasion_name:Faker::Esport.event)
occasion.user = userU
occasion.user_contact = userU.user_contacts.sample
occasion.gift_spec = gift
p occasion
p occasion.save!
userU.user_contacts.each do |c|
  if rand <=0.5
    group_member = GroupMember.new
    group_member.occasion = occasion
    group_member.user_contact = c
    p group_member
    p group_member.save!
  end
end
end


occasion(userU)
occasion(userU)
userM = User.create!(email: 'mena@gmail.com',password: 'aaaaaa')
userM.personnal = Personnal.new(name: 'Menahil',birthday:Date.new(1994,01,1))
userM.save!
contact = Contact.new
contact.user = userM
contact.save!
