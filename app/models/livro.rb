class Livro < ApplicationRecord

  has_many :usuario_livros, dependent: :destroy
  has_many :usuarios, through: :usuario_livros
end
