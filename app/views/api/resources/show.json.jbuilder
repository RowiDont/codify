json.extract! @resource, :id, :link, :description

json.projects do
  json.array! @resource.projects, partial:'api/projects/project', as: :project
end

json.categories do
  json.array! @resource.categories, partial:'api/categories/category', as: :category
end
