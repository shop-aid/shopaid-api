json.extract! project, :id, :description, :name, :local, :favorite, :created_at, :updated_at
json.url project_url(project, format: :json)
