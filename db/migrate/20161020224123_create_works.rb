class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name, null: false
      t.string :cover_image_url
      t.text :description
      t.datetime :date
      t.string :role
      t.string :type
      t.string :content_urls

      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
