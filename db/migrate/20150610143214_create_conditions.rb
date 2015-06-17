class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :shortname
      t.text :legal_description
      t.date :start_date
      t.date :end_date
      t.boolean :active, :default => true
      t.belongs_to :airline, index: true
      t.string :mongodb_id
      t.timestamps 
    end
  end
end
