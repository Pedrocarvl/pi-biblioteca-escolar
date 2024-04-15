class CreateLivros < ActiveRecord::Migration[7.1]
  def change
    create_table :livros do |t|
      t.text :nome
      t.text :descricao

      t.timestamps
    end
  end
end
