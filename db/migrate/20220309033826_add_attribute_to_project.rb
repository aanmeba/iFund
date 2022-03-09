class AddAttributeToProject < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :total_amount, :integer, default: 0
  end
end
