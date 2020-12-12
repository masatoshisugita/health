class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.float :weight
      t.float :bmi
      t.float :sleep_time
      t.string :motion_name
      t.float :motion_time
      t.text :detail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
