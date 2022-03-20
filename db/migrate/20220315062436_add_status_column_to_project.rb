class AddStatusColumnToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :status, :boolean
  end
end
