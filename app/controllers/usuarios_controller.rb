class UsuariosController < ApplicationController
  include Pagy::Backend

  def livros
    @pagy, @livros = pagy(current_usuario.livros)
  end
end
