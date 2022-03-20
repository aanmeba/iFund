class RemoveColumnSupport < ActiveRecord::Migration[6.1]
  def change
    remove_column :supports, :organiser_id
  end
end
