class CreateSupports < ActiveRecord::Migration[6.1]
  def change
    create_table :supports do |t|
      t.references :project, null: false, foreign_key: true
      t.references :organiser, null: false, foreign_key: {to_table: :users}
      t.references :supporter, null: false, foreign_key: {to_table: :users}
      t.string :payment_id
      t.string :receipt_url

      t.timestamps
    end
  end
end
