class DropTableStatus < ActiveRecord::Migration[6.1]
  def change
    drop_table :statuses
  end
end
