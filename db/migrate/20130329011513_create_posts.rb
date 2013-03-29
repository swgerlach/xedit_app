class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :firstName
      t.string :lastName
      t.date :birthday

      t.timestamps
    end
  end
end
