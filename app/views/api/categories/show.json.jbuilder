json.extract! @category, :id, :name

json.resources do
  json.array! @category.resources, partial: 'api/resources/resource', as: :resource
end

json.projects do
  json.array! @category.projects, partial:'api/projects/project', as: :project
end
