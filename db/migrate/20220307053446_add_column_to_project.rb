class AddColumnToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :amount_1, :integer
    add_column :projects, :amount_2, :integer
  end
end
