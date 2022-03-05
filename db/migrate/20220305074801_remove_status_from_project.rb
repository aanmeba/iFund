class RemoveStatusFromProject < ActiveRecord::Migration[6.1]
  def change
    remove_reference :projects, :status, foreign_key: true
  end
end
