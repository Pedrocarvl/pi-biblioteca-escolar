# app/controllers/api/v1/usuario_livros_controller.rb
module Api
  module V1
    class UsuarioLivrosController < Api::ApiController
      def index
        usuario_livros = UsuarioLivro.all
        render json: usuario_livros
      end

      def show
        usuario_livro = UsuarioLivro.find(params[:id])
        render json: usuario_livro
      end
    end
  end
end
