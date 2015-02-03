require 'test_helper'


class AirlineTest < ActiveSupport::TestCase

    setup :initialize_conditions

    test "associate conditions" do
        assert_equal Condition.where(airline_id: @air.id).count, @conds.count
    end

    test "get conditions" do
        assert_equal @air.conditions.count, @conds.count
    end

end
