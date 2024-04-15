class UsuarioLivro < ApplicationRecord
  belongs_to :usuario
  belongs_to :livro
end
