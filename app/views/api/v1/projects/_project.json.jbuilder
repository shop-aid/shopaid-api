json.name project.name
json.description project.description
json.local project.local
json.favorite project.favorite
json.logo project.logo.url(:medium)
json.poster project.poster.url(:medium)
json.category project.category
json.tags project.tags.map(&:name)
