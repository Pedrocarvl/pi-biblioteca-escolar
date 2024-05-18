require 'rails_helper'

RSpec.describe UsuarioLivro, type: :model do
  it { should belong_to(:livro) }
  it { should belong_to(:usuario) }
end
