  namespace :activate_models do
    desc "Activa logicamente los diferentes modelos"
    task :activate_banks => :environment do
        Bank.all.each do |banco|
            banco.active = true
            banco.save
        end
     end   
    task :activate_credit_cards => :environment do
        CreditCard.all.each do |tarjeta|
            tarjeta.active = true
            tarjeta.save
        end
     end       
  end