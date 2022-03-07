class AddColumnsToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :option1_title, :string
    add_column :projects, :option1_amount, :integer
    add_column :projects, :option1_details, :text
    add_column :projects, :option2_title, :string
    add_column :projects, :option2_amount, :integer
    add_column :projects, :option2_details, :text
  end
end
