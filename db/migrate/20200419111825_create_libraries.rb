class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.datetime :expired_time
      t.boolean :active
      t.references :libraryable, polymorphic: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
