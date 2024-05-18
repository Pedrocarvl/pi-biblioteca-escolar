require 'rails_helper'

RSpec.describe Usuario, type: :model do
  it { should have_many(:usuario_livros) }
  it { should have_many(:livros).through(:usuario_livros) }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }

  it { should define_enum_for(:tipo).with_values([:admin, :user]).backed_by_column_of_type(:integer) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password).on(:create) }
  it { should allow_value('email@address.com').for(:email) }

  describe 'default values' do
    it 'sets the default value of tipo to :user' do
      usuario = Usuario.new
      expect(usuario.tipo).to eq('user')
    end
  end
end
