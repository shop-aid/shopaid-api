json.name cause.name
json.description cause.description
json.local cause.local
json.favorite cause.favorite
json.logo cause.logo.url(:medium)
json.poster cause.poster.url
json.category cause.category
json.tags cause.tags.map(&:name)
