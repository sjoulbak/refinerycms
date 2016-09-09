class AddAncestryToRefineryPages < ActiveRecord::Migration
  def up
    add_column :refinery_pages, :ancestry, :string
    add_index :refinery_pages, :ancestry

    begin
      ::Refinery::Page.build_ancestry_from_parent_ids!
      ::Refinery::Page.check_ancestry_integrity!
    rescue NameError
      warn "::Refinery::Page was not defined!"
    end

    remove_column :refinery_pages, :parent_id
    remove_column :refinery_pages, :lft
    remove_column :refinery_pages, :rgt
    remove_column :refinery_pages, :depth
  end

  def down
    remove_column :refinery_pages, :ancestry
    remove_index :refinery_pages, :ancestry

    add_column :refinery_pages, :parent_id, :integer
    add_column :refinery_pages, :lft, :integer
    add_column :refinery_pages, :rgt, :integer
    add_column :refinery_pages, :depth, :integer
  end
end
