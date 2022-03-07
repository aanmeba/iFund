class RemoveColumnsFromProject < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :amount_1, :string
    remove_column :projects, :amount_2, :string
  end
end
