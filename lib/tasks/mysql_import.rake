require 'csv'
namespace :mysql_import do
  task :values => :environment do
    file = "db/values-list.csv"
    CSV.foreach(file , :headers => true) do |row|
      Value.create({"mongodb_id"=>row['mongodb_id'], "quota"=>row['quota'], "coefficient_mongodb_id"=>row['coefficient_id'], "value"=>row['value']})  unless row.all?(&:nil?)
    end
  end

  task :coefficients => :environment do
    file = "db/coefficient-list.csv"
    CSV.foreach(file , :headers => true) do |row|
      unless row.all?(&:nil?)
        Coefficient.create({"mongodb_id"=>row['mongodb_id'], "start_date"=>row['start_date'], "end_date"=>row['end_date'], "active"=>row['active'], "credit_card_id"=>1, "credit_card_mongodb_id"=>row['credit_card_id'], "condition_mongodb_id"=>row['condition_id']}) 
        # p "Id: #{c.id}"
        # p "Errors: #{c.errors.full_messages}"
      end
    end
  end

  task :promotions => :environment do
    file = "db/promotion-list"
    CSV.foreach(file , :headers => true) do |row|
      Promotion.create({'mongodb_id'=>row['mongodb_id'],'quota'=>row['quota'],'commerce_number'=>row['commerce_number'], 'bin'=>row['bin'],'observations'=>row['observations'], 'observationsb2c'=>row['observationsb2c'],'start_date'=>row['start_date'],'end_date'=>row['end_date'], 'active'=>row['active'],'credit_card_mongodb_id'=>row['credit_card_id'],'bank_mongodb_id'=>row['bank_id'], 'condition_mongodb_id'=>row['condition_id'], "credit_card_id"=>nil,}) unless row.all?(&:nil?)
    end
  end

  task :conditions => :environment do
    file = "db/condition-list.csv"
    CSV.foreach(file , :headers => true) do |row|
      unless row.all?(&:nil?)
        c = Condition.new ({'mongodb_id'=>row['mongodb_id'],'shortname'=>row['shortname'],'legal_description'=>row['legal_description'], 'start_date'=>row['start_date'].to_date,'end_date'=>row['end_date'].to_date, 'active'=>row['active'],'airline_id'=>row['airline_id']}) 
        c.save(validate: false)
        # p "#{c.errors.full_messages}"
      end
    end
  end


  task :update_value_coefficient_id => :environment do  
    coefficients=Coefficient.all
    Value.all.each do |v|
      coeficiente = Coefficient.find_by mongodb_id:('  ' + v.coefficient_mongodb_id)
      v.coefficient_id = coeficiente.id unless coeficiente.blank?
      v.save
    end
  end

  task :update_coefficients_ids => :environment do  
    credit_cards=CreditCard.all
    conditions=Condition.all
    Coefficient.all.each do |c|
      tarjeta = credit_cards.detect { |cc| cc.mongodb_id == ('  ' + c.credit_card_mongodb_id)}
      c.credit_card_id = tarjeta.id unless tarjeta.blank?
      condicion = Condition.find_by mongodb_id:('  ' + c.condition_mongodb_id)
      c.condition_id = condicion.id unless condicion.blank?
      c.save
    end
  end

  task :update_promotions_ids => :environment do  
    credit_cards=CreditCard.all
    banks=Bank.all
    conditions=Condition.all
    Promotion.all.each do |pr|
      tarjeta = credit_cards.detect { |cc| cc.mongodb_id == ('  ' + pr.credit_card_mongodb_id)}
      pr.credit_card_id = tarjeta.id unless tarjeta.blank?
      banco = banks.detect { |b| b.mongodb_id == ('  ' + pr.bank_mongodb_id)}
      pr.bank_id = banco.id unless banco.blank?
      condicion = conditions.detect { |cond| cond.mongodb_id == ('  ' + pr.condition_mongodb_id)}
      pr.condition_id = condicion.id unless condicion.blank?
      pr.save
    end
  end  


  # task :update_bank_mongodb_id => :environment do  
  #   banks=Bank.all
  #   ToUseCreditCard.all.each do |to_use_credit_card|
  #     to_use_credit_card.bank_id = banks.detect { |bank| bank.mongodb_id == to_use_credit_card.bank_mongodb_id  }.id
  #     to_use_credit_card.save
  #   end
  # end

  # task :update_card_mongodb_id => :environment do  
  #   cards=CreditCard.all
  #   ToUseCreditCard.all.each do |to_use_credit_card|
  #     to_use_credit_card.credit_card_id = cards.detect { |card| card.mongodb_id == to_use_credit_card.card_mongodb_id  }.id
  #     to_use_credit_card.save
  #   end
  # end


end