class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :quota
      t.float :value
      t.belongs_to :coefficient, index: true
      t.string :coefficient_mongodb_id
      t.string :mongodb_id
      t.timestamps
    end
  end
end
