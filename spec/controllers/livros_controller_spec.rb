# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LivrosController, type: :controller do
  let(:usuario) { create(:usuario) }
  let(:valid_attributes) { attributes_for(:livro) }
  let(:invalid_attributes) { { nome: nil } }
  let(:livro) { create(:livro) }

  before do
    sign_in usuario
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: livro.to_param }
      expect(response).to be_successful
    end

    context "with turbo_stream format" do
      it 'returns a success response' do
        get :show, params: { id: livro.to_param }, format: :turbo_stream
        expect(response).to be_successful
      end
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: livro.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Livro" do
        expect do
          post :create, params: { livro: valid_attributes }
        end.to change(Livro, :count).by(1)
      end

      it "redirects to the livros list" do
        post :create, params: { livro: valid_attributes }
        expect(response).to redirect_to(livros_path)
        expect(flash[:notice]).to match("Livro foi criado com sucesso.")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { nome: 'Novo Nome' }
      end

      it "updates the requested livro" do
        put :update, params: { id: livro.to_param, livro: new_attributes }
        livro.reload
        expect(livro.nome).to eq('Novo Nome')
      end

      it "redirects to the livro" do
        put :update, params: { id: livro.to_param, livro: valid_attributes }
        expect(response).to redirect_to(livro)
        expect(flash[:notice]).to match("Livro foi atualizado com sucesso.")
      end
    end
  end

  describe "POST #borrow" do
    it "borrows the requested livro" do
      expect do
        post :borrow, params: { id: livro.to_param }
      end.to change(UsuarioLivro, :count).by(1)
    end

    it "redirects to the livros_usuarios list" do
      post :borrow, params: { id: livro.to_param }
      expect(response).to redirect_to(livros_usuarios_path)
      expect(flash[:notice]).to match("Livro foi emprestado com sucesso.")
    end
  end

  describe "POST #return" do
    before do
      livro.usuario_livros.create!(usuario: usuario, borrowed_at: Time.current)
    end

    it "returns the borrowed livro" do
      expect do
        post :return, params: { id: livro.to_param }
      end.to change { livro.usuario_livros.where(returned_at: nil).count }.by(-1)
    end

    it "redirects to the livros_usuarios list" do
      post :return, params: { id: livro.to_param }
      expect(response).to redirect_to(livros_usuarios_path)
      expect(flash[:notice]).to match("Livro foi devolvido com sucesso.")
    end
  end

  describe "GET #list" do
    render_views

    it "returns a success response with expected livros" do
      get :list, params: { search: 'Sample' }
      expect(response).to be_successful
    end
  end
end
