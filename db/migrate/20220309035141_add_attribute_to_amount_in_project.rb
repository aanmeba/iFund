class AddAttributeToAmountInProject < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :amount, :integer, default: 0
  end
end
