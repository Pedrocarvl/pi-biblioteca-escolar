require 'rails_helper'

RSpec.describe Livro, type: :model do
  it { should have_many(:usuario_livros) }
  it { should have_many(:usuarios).through(:usuario_livros) }
  it { should have_one_attached(:image) }
end
