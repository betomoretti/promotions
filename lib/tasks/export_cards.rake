require 'csv'
namespace :cards do
  task :export => :environment do
    file = "db/cards_mongo.csv"
    CSV.open(file, "wb") do |csv|
      csv << ['mongodb_id', 'name', 'quantity_digits','bin_start', 'quantity_code_security', 'active', "created_at", "updated_at"]
      CreditCard.all.each do |card|
        csv << [card.id.to_s, card.name, card.quantity_digits,card.bin_start, card.quantity_code_security, card.active, card.created_at, card.updated_at]
      end 
    end
  end
end