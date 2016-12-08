class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :title, default: ''
      t.text :description, default: ''
      t.string :slug, default: ''
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
