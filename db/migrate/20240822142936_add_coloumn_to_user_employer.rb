class AddColoumnToUserEmployer < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :flagged, :boolean, default: false
    add_column :employers, :flagged, :boolean, default: false
  end
end
