json.extract! @user, :id, :email

json.categories @user.categories
json.projects @user.projects
