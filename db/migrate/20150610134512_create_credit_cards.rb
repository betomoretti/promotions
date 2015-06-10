class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.integer :quantity_digits
      t.integer :bin_start
      t.integer :quantity_code_security
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
