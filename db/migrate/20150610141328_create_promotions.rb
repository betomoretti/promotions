class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :quota
      t.string :bin
      t.string :commerce_number
      t.text :observations
      t.text :observationsb2c
      t.date :start_date
      t.date :end_date
      t.belongs_to :bank, index: true
      t.string :bank_mongodb_id
      t.belongs_to :credit_card, index: true
      t.string :credit_card_mongodb_id
      t.belongs_to :condition, index: true
      t.string :condition_mongodb_id
      t.boolean :active, :default => true  
      t.string :mongodb_id
      t.timestamps
    end
  end
end
