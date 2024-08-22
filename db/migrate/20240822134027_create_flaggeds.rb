class CreateFlaggeds < ActiveRecord::Migration[7.0]
  def change
    create_table :flaggeds do |t|
      t.references :flaggable, polymorphic: true, null: false
      t.references :flagger, polymorphic: true, null: false

      t.timestamps
    end
  end
end
