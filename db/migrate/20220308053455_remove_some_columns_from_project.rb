class RemoveSomeColumnsFromProject < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :option1_title, :string
    remove_column :projects, :option1_amount, :integer
    remove_column :projects, :option1_details, :text
    remove_column :projects, :option2_title, :string
    remove_column :projects, :option2_amount, :integer
    remove_column :projects, :option2_details, :text
  end
end
