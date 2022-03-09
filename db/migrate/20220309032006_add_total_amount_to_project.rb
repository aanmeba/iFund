class AddTotalAmountToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :total_amount, :integer
  end
end
