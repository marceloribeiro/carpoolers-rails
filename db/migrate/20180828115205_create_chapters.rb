class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :slug

      t.timestamps
    end

    add_index :chapters, :state
    add_index :chapters, :slug
  end
end
