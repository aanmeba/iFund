class AddAmountToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :amount, :integer
  end
end
