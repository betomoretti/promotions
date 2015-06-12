class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:edit, :update, :destroy, :enable, :disable, :clone]
  before_action :set_banks_credit_cards, only: [:new, :edit]

  # GET /promotions/new
  def new
    @promotion = Promotion.new
    @promotion.start_date = params[:start_date] unless params[:start_date].blank?
    @promotion.end_date = params[:end_date] unless params[:end_date].blank?
    render layout: false 
  end
  
  def export_to_csv
    @promotions = Promotion.all.order(created_at: :desc)
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"promotion-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end  
  end  


  # POST /promotions/1/clone
  def clone
    @promotion = @promotion.clone
    respond_to do |format|
      if @promotion.save
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :promotion => @promotion, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @promotion.errors }, :status => 409 }
      end
    end
  end

  # PATCH /promotions/1/enable
  def enable
    respond_to do |format|
      if @promotion.update_attribute(:active, true)
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :promotion => @promotion, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @promotion.errors }, :status => 409 }
      end
    end
  end

  # PATCH /promotions/1/disable
  def disable
    respond_to do |format|
      if @promotion.update_attribute(:active, false)
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :promotion => @promotion, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @promotion.errors }, :status => 409 }
      end
    end
  end

  # GET /promotions/1/edit
  def edit
    @promotion.start_date = @promotion.start_date.strftime("%d/%m/%Y")
    @promotion.end_date = @promotion.end_date.strftime("%d/%m/%Y")
    render layout: false
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)
    @render_hidden_input = true if request.xhr?
    respond_to do |format|
      if @promotion.save
        format.html { render :partial => "row_table", :locals => { :promotion => @promotion, :render_hidden_input => @render_hidden_input } }
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
    if @promotion.delete 
      render :nothing => true, :status => 200 
    else 
      render :nothing => true, :status => 503
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
      params.require(:promotion).permit(:condition_id, :quota, :bin, :bank_id, :credit_card_id, :start_date, :end_date, :observations,:observationsb2c, :comerce_number, :active)
    end
end
