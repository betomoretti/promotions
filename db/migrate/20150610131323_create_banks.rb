class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
