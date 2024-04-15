json.extract! livro, :id, :nome, :descricao, :created_at, :updated_at
json.url livro_url(livro, format: :json)
