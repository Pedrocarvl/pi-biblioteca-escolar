class CreateUsuarioLivros < ActiveRecord::Migration[7.1]
  def change
    create_table :usuario_livros do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :livro, null: false, foreign_key: true
      t.datetime :borrowed_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
