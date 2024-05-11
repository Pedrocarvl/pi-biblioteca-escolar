class Livro < ApplicationRecord
  include SearchField

  has_many :usuario_livros, dependent: :destroy
  has_many :usuarios, through: :usuario_livros

  has_one_attached :image

  def image_as_thumbnail
    image.variant(resize_to_limit: [407, 201]).processed
  end
end
