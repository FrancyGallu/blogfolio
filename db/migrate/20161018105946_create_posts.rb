class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string     :title, null: false
      t.text       :body
      t.references :author, index: true

      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_index :posts, :title
  end
end
