json.airlines @airlines do |airline|
    json.name airline.name
end

json.credit_cards @credit_cards do |credit_card|
    json.name credit_card.name
end

json.banks @banks do |bank|
    json.name bank.name
end