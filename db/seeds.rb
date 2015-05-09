User.create!(username: "Bob", email: "bob@gmail.com", password: "password")

Dog.create!(owner: User.find_by(username: "Bob"), name: "Spot", birthday: "January 5, 1999", breed: "Sheltie")


# DBC Walkabout
Walk.create!(user_id: 1)
Mark.create!(walk_id: 1, latitude: 41.889685, longitude: -87.63775, accuracy: 20)
Mark.create!(walk_id: 1, latitude: 41.888969, longitude: -87.63392, accuracy: 20)
Mark.create!(walk_id: 1, latitude: 41.889092, longitude: -87.63801, accuracy: 20)
Mark.create!(walk_id: 1, latitude: 41.889685, longitude: -87.63775, accuracy: 20)



