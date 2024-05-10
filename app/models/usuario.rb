class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum :tipo, [:admin, :user], default: :user

  has_many :usuario_livros
  has_many :livros, through: :usuario_livros

end
