class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :image
      t.float :height  
      t.timestamps
      t.index :email, unique:true
    end
  end
end
