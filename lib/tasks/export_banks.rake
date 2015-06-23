require 'csv'
namespace :banks do
  task :export => :environment do
    file = "db/banks_mongo.csv"
    CSV.open(file, "wb") do |csv|
      csv << ["mongodb_id", "name", "active", "created_at", "updated_at"]
      Bank.all.each do |bank|
        csv << [bank.id.to_s, bank.name, bank.active,bank.created_at, bank.updated_at]
      end 
    end
  end
end