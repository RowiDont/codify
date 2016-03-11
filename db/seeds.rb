user = User.create!(email: "rafiepatel@gmail.com")
user2 = User.create!(email: "rimon@gmail.com")

redux = user.categories.create(name: "Redux")
rails = user.categories.create(name: "Rails")
flux = user2.categories.create(name: "flux")

link1 = redux.resources.create(link: "https://github.com/jackielii/simplest-redux-example/blob/master/index.js")
link2 = redux.resources.create(link: "http://redux.js.org/")
ResourceUser.create(user: user, resource: link1)
ResourceUser.create(user: user, resource: link2)

project1 = Project.create!(title: "a project!", user_id: user.id)
link3 = project1.resources.create(link: "https://github.com/thoughtbot/paperclip/wiki/Interpolations")
ResourceUser.create(user: user, resource: link3)

ProjectResource.create!(project_id: project1.id, resource_id: link1.id)

CategoryProject.create(category: redux, project: project1)
