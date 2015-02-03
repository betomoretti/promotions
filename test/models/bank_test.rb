require 'test_helper'

class BankTest < ActiveSupport::TestCase
    setup :initialiaze_promotion

    test "set promotion" do
        assert_equal @bank.promotions.first.id, @promotion.id
    end
end
