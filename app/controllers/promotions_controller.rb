class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  before_action :set_banks_credit_cards, only: [:new, :edit]

  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = Promotion.all
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
    render :layout => false
  end

  # GET /promotions/1/edit
  def edit
    render :layout => false
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)
    respond_to do |format|
      if @promotion.save
        format.html { render :partial => "row_table", :locals => {:promotion => @promotion} }
      else
        format.json { render :json => { :errors => @promotion.errors }, :status => 409 }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @promotion.update(promotion_params)
        format.html { render :partial => "row_table", :locals => {:promotion => @promotion} }
      else
        format.json { render :json => { :errors => @promotion.errors }, :status => 409 }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    def set_banks_credit_cards
      @banks = Bank.all.map { |bank| [bank.name, bank.id] }
      @credit_cards = CreditCard.all.map { |credit_card| [credit_card.name, credit_card.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_params
      params.require(:promotion).permit(:quota, :bin, :bank_id, :credit_card_id)
    end
end
