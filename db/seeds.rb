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

man = ["This chef's passion for fusion cuisine is complemented by his love for cycling. He's also a wine enthusiast, often organizing wine and dine events. His kitchen at home is a testament to his culinary adventures, filled with cookbooks and exotic spices. On weekends, he enjoys long cycling trips, exploring rural landscapes and enjoying the tranquility of nature.",
       "Apart from his love for antique books, this professor is deeply interested in history and linguistics. He often spends evenings giving lectures at local history clubs. His home is a mini-museum, adorned with historical artifacts and rare manuscripts, reflecting his academic interests.",
       "His architectural work is just one aspect of his artistic talent. He also enjoys model building and 3D printing, often creating miniatures of his designs. His love for cityscapes is evident in his detailed sketches, capturing the dynamic nature of urban life.",
       "In addition to his fitness career, he's an outdoor enthusiast, often participating in adventure races. He also practices yoga, finding it a perfect balance to his more intense physical activities. His weekends are spent on hiking trails, embracing the challenge and serenity of the mountains.",
       "His strategic mind is not just for business but also for chess. He has a keen interest in artificial intelligence and enjoys attending tech conferences. At home, he has a dedicated space for his chess practice, often hosting friendly matches with fellow enthusiasts.",
       "This musician finds his creative muse in his garden. He's also an amateur cook, often hosting backyard barbecues where he shares both his culinary creations and musical talents. His garden is his sanctuary, a place where he composes and rehearses his music.",
       "His artistic skills extend to digital art and animation. He enjoys creating street art, often participating in local mural projects. His home is a canvas of his own design, showcasing his artistic works and skateboard collection.",
       "His dedication to marine biology is matched by his passion for underwater photography. He's involved in ocean conservation efforts and often speaks at environmental workshops. His home is filled with marine artifacts and his stunning underwater photographs.",
       "Besides photography, he's fascinated by space and astrophysics, often attending stargazing events and astronomy clubs. His photography studio is a blend of camera equipment and telescopes, reflecting his dual passions for photography and star gazing.",
       "His woodworking hobby is an outlet for his creativity and precision. He's also a motorcycle enthusiast, often going on rides to unwind. His workshop is a haven of handcrafted projects, from intricate furniture pieces to artistic wooden sculptures."]

woman = [" This woman is a true plant enthusiast. Not only does she love exotic flowers and birdwatching, but she also has a passion for herbalism, creating her own herbal remedies and teas. She's a regular at local plant fairs and enjoys giving talks on sustainable gardening practices. Her home resembles a greenhouse, filled with a variety of plant species and DIY hydroponic systems.",
         "Beyond her career in tech and rock climbing, she has a keen interest in robotics and often participates in hackathons. She enjoys hiking and geocaching on weekends, combining her love for technology and nature. Her living space is a blend of high-tech gadgets and climbing gear, reflecting her diverse interests.",
         "Apart from writing, she is an avid reader, with a personal library that spans many genres. She enjoys journaling and blogging about her travels and experiences by the sea. She's also a fan of classical music and often attends concerts and operas, finding inspiration in the melodies.",
         "Her love for the arts doesn't stop at music and dance. She's also an accomplished sketch artist, often drawing scenes from her travels and experiences. She enjoys teaching violin to children in her community, sharing her passion for music with the next generation.",
         "She's fascinated by astrophysics and enjoys attending star-gazing events and space-themed workshops. Her baking skills are complemented by her interest in molecular gastronomy, often experimenting with new culinary techniques. She also enjoys creating baking tutorial videos for her online followers.",
         "This woman is not just a filmmaker but also a keen photographer, capturing candid moments and street photography. She loves vintage cinema and collects old film posters and memorabilia. Her home is decorated with her own photography and film-inspired art.",
         "She is also a passionate advocate for wildlife conservation. In her downtime, she enjoys birdwatching and nature hikes. She often volunteers for animal rescue missions and writes a blog about veterinary care and animal welfare.",
         "Her artistic talents extend to painting and sculpting. She's a DIY enthusiast, often undertaking home decoration projects. She participates in local art and craft fairs, displaying her pottery and handmade home decor items.",
         "Besides her yoga and photography hobbies, she's a keen gardener, growing her own herbs and flowers. She loves watercolor painting, often depicting scenes from nature and her travels. She also practices mindfulness meditation, which she incorporates into her yoga teaching.",
         "Her enthusiasm for the ocean is matched by her interest in marine biology and environmental activism. She enjoys kayaking and paddle boarding, exploring different coastal areas. She's also an amateur marine photographer, capturing the diverse beauty of sea life."]

# creating userlogin for mains
userU = User.create!(email: "nak@me.com", password: "kalvin")

userU.personnal = Personnal.new(name: "Francois", birthday: Date.new(1971, 01, 14), info: { picture: "Francois.png", profile: man.sample }, notifications: true)
print userU, userU.save!

userM = User.create!(email: "mena@gmail.com", password: "aaaaaa")
userM.personnal = Personnal.new(name: "Menahil", birthday: Date.new(1994, 01, 1), info: { picture: "Mena.jpeg", profile: woman.sample }, notifications: false)
userM.save!

userE = User.create!(email: "elimrfortes@gmail.com", password: "blabla")
userE.personnal = Personnal.new(name: "Eli", birthday: Date.new(1992, 01, 1), info: { picture: "Eli.jpeg", profile: woman.sample }, notifications: true)
userE.save!

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

# only_on_dev
#  occasion(userU, array, userM, userE)
#  occasion(userM, array, userU, userE)
#  occasion(userE, array, userU, userM)
