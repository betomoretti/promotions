require 'test_helper'

class ConditionTest < ActiveSupport::TestCase
    
    setup :initialize_conditions
    
    test "get airline" do
        @conds.each do |val|
            assert_equal val.airline.id, @air.id
        end
    end

    test "validate dates" do
        assert Condition.create(start_date: Date.today(), end_date: Date.today()+30, airline_id: Airline.first).persisted?  
        assert_not Condition.create(start_date: Date.today()+30, end_date: Date.today(), airline_id: Airline.first).persisted?
        assert_not Condition.create(start_date: Date.today(), end_date: Date.today(), airline_id: Airline.first).persisted?
        assert_not Condition.create(start_date: Date.today()-20, end_date: Date.today()+30, airline_id: Airline.first).persisted?
        assert_not Condition.create(start_date: Date.today(), end_date: Date.today()-30, airline_id: Airline.first).persisted?  
    end
end
