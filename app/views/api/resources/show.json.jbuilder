json.extract! @resource, :id, :link, :description

json.projects @resource.projects
json.categories @resource.categories
