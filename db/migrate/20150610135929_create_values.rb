class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :quota
      t.decimal :value
      t.belongs_to :coefficient, index: true
      t.timestamps
    end
  end
end