namespace :livros do
  desc "Criar livros aleatórios"
  task criar: :environment do
    ActiveRecord::Base.transaction do
      100.times do
        Livro.create!(
          #titulo: Faker::Book.title,
          #autor: Faker::Book.author,
          #genero: Faker::Book.genre,
          #editora: Faker::Book.publisher,
          #ano: Faker::Number.between(from: 1900, to: 2021),
          #paginas: Faker::Number.between(from: 50, to: 1000),
          #preco: Faker::Commerce.price(range: 10.0..100.0)
          nome: Faker::Book.title,
          descricao: Faker::Lorem.paragraph(sentence_count: 3)
        )
      end
    end
  end
end