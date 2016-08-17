class AddExpandedToRefineryPages < ActiveRecord::Migration
  def change
    add_column :refinery_pages, :expanded, :boolean, default: false
  end
end
