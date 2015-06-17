class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :active, :default => true
      t.belongs_to :credit_card, index: true
      t.string :credit_card_mongodb_id
      t.belongs_to :condition, index: true
      t.string :condition_mongodb_id
      t.string :mongodb_id
      t.timestamps
    end
  end
end
