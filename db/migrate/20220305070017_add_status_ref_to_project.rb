class AddStatusRefToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :status, null: false, foreign_key: true
  end
end
