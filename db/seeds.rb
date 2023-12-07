# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "faker"

# clean database
Product.destroy_all
Gift.destroy_all
UserContact.destroy_all
Myoccasion.destroy_all
Occasion.destroy_all
Question.destroy_all
Answer.destroy_all
User.destroy_all
# creating userlogin for mains
userU = User.create!(email: "nak@me.com", password: "kalvin")

userU.personnal = Personnal.new(name: "Francois", birthday: Date.new(1971, 01, 14), info: { picture: "Francois.png" }, notifications: true)
print userU, userU.save!

userM = User.create!(email: "mena@gmail.com", password: "aaaaaa")
userM.personnal = Personnal.new(name: "Menahil", birthday: Date.new(1994, 01, 1), info: { picture: "Mena.jpeg" }, notifications: false)
userM.save!

userE = User.create!(email: "elimrfortes@gmail.com", password: "blabla")
userE.personnal = Personnal.new(name: "Eli", birthday: Date.new(1992, 01, 1), info: { picture: "Eli.jpeg" }, notifications: true)
userE.save!

man = ["A chef with a flair for fusion cuisine, known for his weekend cycling trips through the countryside, often spotted in cycling gear on sunny mornings.",
       "A professor with a love for antique books, spends his free time browsing through old bookstores, always with a rare find under his arm.",
       "An architect who enjoys urban sketching, often seen in public parks with his sketchbook, capturing the essence of cityscapes.",
       "A personal trainer with a passion for hiking, spends his weekends exploring mountain trails, equipped with a backpack and hiking boots.",
       "A tech entrepreneur who relaxes by playing chess, frequently participating in local chess club tournaments, showcasing strategic thinking.",
       "A musician who loves gardening, spends his afternoons tending to his backyard garden, creating a serene environment for his musical inspirations.",
       "A graphic designer who is an avid skateboarder, often seen at skate parks performing tricks, blending his artistic style with his love for skateboarding.",
       "A marine biologist dedicated to scuba diving, explores coral reefs and marine ecosystems during his diving expeditions.",
       "A photographer with a penchant for star gazing, spends nights capturing the beauty of the night sky, combining his love for photography and astronomy.",
       "A firefighter who unwinds by woodworking, creating handcrafted furniture and decor in his workshop, demonstrating skill and precision."]

woman = [" A botanist with a fascination for exotic flowers, spends her weekends in botanical gardens, often found sketching rare plants and flowers.",
         "A software developer who unwinds by rock climbing, challenging herself on steep climbs, often seen at local climbing gyms or outdoor crags.",
         "A novelist who finds inspiration by the sea, frequently spotted at beachside cafes, deeply engrossed in writing her latest book.",
         "A professional violinist with a love for salsa dancing, spends her evenings at dance studios, merging her musical talent with rhythmic dance steps.",
         "An aerospace engineer with a passion for baking, known for creating elaborate cakes and pastries, often sharing her creations with colleagues.",
         "A film director who enjoys urban exploration, often embarks on adventures to discover hidden gems in the city, seeking inspiration for her next film.",
         "A veterinarian who loves horseback riding, spends her free time at a local stable, combining her love for animals with equestrian sports.",
         "An interior designer with a knack for pottery, enjoys crafting unique ceramic pieces, often incorporating them into her design projects.",
         "A yoga instructor with a passion for photography, captures serene landscapes and candid moments, reflecting the tranquility of her yoga practice.",
         "A marine scientist dedicated to surfing, finds balance between her scientific pursuits and riding the ocean waves, often seen at the beach at dawn."]

# creating 30 users for login with userxx@me.com
def users(man, woman)
  10.times do |i|
    user = User.new(email: "user0#{i}@gmail.com")
    user.password = "123456"
    personnal = Personnal.new(
      name: Faker::Name.name,
      birthday: Faker::Date.birthday,
      info: { sex: "man", picture: "man/man-0#{i}.jpg", profile: man.sample },
    )
    mycontacts = Mycontact.new
    mycontacts.user = user
    mycontacts.save!
    user.personnal = personnal
    print i, user.save!
  end
  10.times do |i|
    user = User.new(email: "user1#{i}@gmail.com")
    user.password = "123456"
    personnal = Personnal.new(
      name: Faker::Name.name,
      birthday: Faker::Date.birthday,
      info: { sex: "woman", picture: "woman/woman-0#{i}.jpg", profile: woman.sample },
    )
    mycontacts = Mycontact.new
    mycontacts.user = user
    mycontacts.save!
    user.personnal = personnal
    print i, user.save!
  end
end

users(man, woman)

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
    price: 100,
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
      gift: myoccasion.gift,
      # same gift for all occasions created in the loop
      #title: gift.title,
      #gift_id: gift.id,
    )
    occasion.myoccasion = myoccasion
    userR = User.find(p)
    occasion.user = userR
    occasion.save!

    question = Question.new(
      myoccasion: myoccasion.id,
      recipient: myoccasion.recipient,
      gift: gift.id,
    )
    question.occasion = occasion
    question.user = userR
    question.save!
    p question

    proposal = Proposal.new
    proposal.occasion = occasion
    proposal.myoccasion = myoccasion

    proposal.save!

    5.times do |p|
      product = Product.new(title: p, price: rand(1..300), row_order: p, position: p)
      product.url = "product/product-#{rand(10..19)}.jpg"
      product.title = Faker::Commerce.product_name
      product.proposal = proposal

      product.save!
    end
  end
end

occasion(userU, array, userM, userE)
occasion(userM, array, userU, userE)
occasion(userE, array, userU, userM)
