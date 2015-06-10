class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :quota
      t.string :bin
      t.string :commerce_number
      t.string :observations
      t.string :observationsb2c
      t.date :start_date
      t.date :end_date
      t.belongs_to :bank, index: true
      t.belongs_to :credit_card, index: true
      t.belongs_to :condition, index: true
      t.boolean :active, :default => true  
      t.timestamps
    end
  end
end
