class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :ticket
      t.string :asset

      t.timestamps
    end

    remove_column :tickets, :asset
  end
end
