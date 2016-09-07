class AddAncestryToRefineryPages < ActiveRecord::Migration
  def up
    add_column :refinery_pages, :ancestry, :string
    add_index :refinery_pages, :ancestry

    Refinery::Pages.build_ancestry_from_parent_ids
    Refinery::Pages.check_ancestry_integrity!

    remove_column :refinery_pages, :parent_id
  end

  def down
    remove_column :refinery_pages, :ancestry
    remove_index :refinery_pages, :ancestry

    add_column :refinery_pages, :parent_id, :integer
  end
end
