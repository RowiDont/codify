json.extract! @category, :id, :name

json.resources @category.resources
json.projects @category.projects
