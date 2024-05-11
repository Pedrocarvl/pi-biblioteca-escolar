class LivrosController < ApplicationController
  before_action :set_livro, only: %i[ show edit update destroy borrow return ]

  # GET /livros or /livros.json
  def index
    @pagy, @livros = pagy(
      Livro.left_joins(:usuario_livros)
           .where(usuario_livros: { id: nil })
           .or(Livro.left_joins(:usuario_livros).where.not(usuario_livros: { returned_at: nil }))
           .distinct
           .order(created_at: :desc)
    )
  end

  # GET /livros/1 or /livros/1.json
  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /livros/new
  def new
    @livro = Livro.new
  end

  # GET /livros/1/edit
  def edit
  end

  # POST /livros or /livros.json
  def create
    @livro = Livro.new(livro_params)

    if @livro.save
      redirect_to livros_path, notice: "Livro foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /livros/1 or /livros/1.json
  def update
    respond_to do |format|
      if @livro.update(livro_params)
        format.html { redirect_to livro_url(@livro), notice: "Livro foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @livro }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @livro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /livros/1 or /livros/1.json
  def destroy
    @livro.destroy!

    respond_to do |format|
      format.html { redirect_to livros_url, notice: "Livro foi excluído com sucesso." }
      format.json { head :no_content }
    end
  end

  def borrow
    @livro.usuario_livros.create!(usuario: current_usuario, borrowed_at: Time.current)

    redirect_to livros_usuarios_path, notice: "Livro foi emprestado com sucesso."
  end

  def return
    @livro.usuario_livros.find_by!(returned_at: nil).update!(returned_at: Time.current)

    redirect_to livros_usuarios_path, notice: "Livro foi devolvido com sucesso."
  end

  def list
    livros = Livro.left_joins(:usuario_livros)
         .where(usuario_livros: { id: nil })
         .or(Livro.left_joins(:usuario_livros).where.not(usuario_livros: { returned_at: nil }))
         .distinct
         .order(created_at: :desc)

    columns = %w[livros.nome livros.descricao]
    livros = livros.search_all_fields(params[:search], columns) if params[:search].present?

    @pagy, @livros = pagy(livros)

    render(partial: 'livros', locals: { livros: @livros })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_livro
      @livro = Livro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def livro_params
      params.require(:livro).permit(:nome, :descricao, :image)
    end
end
