User.create!(username: "Bob", email: "bob@gmail.com", password: "password")

Dog.create!(owner: User.find_by(username: "Bob"), name: "Spot", birthday: "January 5, 1999", breed: "Sheltie")




