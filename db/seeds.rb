user = User.create!(email: "rafiepatel@gmail.com")

redux = user.categories.create(name: "Redux")
rails = user.categories.create(name: "Rails")

link1 = Resource.create(link: "google.com")
