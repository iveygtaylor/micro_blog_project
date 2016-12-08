class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, default: ''
      t.text :body, default: ''
      t.string :slug, default: ''
      t.belongs_to :blog

      t.timestamps
    end
  end
end
