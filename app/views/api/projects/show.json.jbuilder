json.extract! @project
json.resources do
  json.array! @project.resources do |resource|
    json.id resource.id
    json.name resource.link
    json.categories do
      json.array! resource.categories, partial:'api/categories/category', as: :category
    end
  end
end
