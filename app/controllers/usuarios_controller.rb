class UsuariosController < ApplicationController
  include Pagy::Backend

  def livros
    @pagy, @livros = pagy(current_usuario.usuario_livros.includes(:livro).order(created_at: :desc))
  end
end
