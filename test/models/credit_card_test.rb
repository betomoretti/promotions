require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
    setup :initialiaze_promotion

    test "set promotion" do
        assert_equal @credit_card.promotions.first.id, @promotion.id
    end

end
