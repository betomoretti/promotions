class CoefficientsController < ApplicationController
  before_action :set_coefficient, only: [:edit, :update, :destroy, :enable, :disable]
  before_action :set_credit_cards, only: [:new, :edit]

  # GET /promotions/new
  def new
    @coefficient = Coefficient.new
    render layout: false
  end
  
  # GET /promotions/1/edit
  def edit
    render layout: false
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @coefficient = Coefficient.new(promotion_params)
    @render_hidden_input = true if request.xhr?
    respond_to do |format|
      if @coefficient.save
        format.html { render :partial => "row_table", :locals => { :promotion => @coefficient, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @coefficient.update(promotion_params)
        format.html { render :partial => "row_table", :locals => {:promotion => @coefficient} }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    if @coefficient.delete 
      render :nothing => true, :status => 200 
    else 
      render :nothing => true, :status => 503
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coefficient
      @coefficient = Coefficient.find(params[:id])
    end

    def set_credit_cards
      @credit_cards = CreditCard.all.map { |credit_card| [credit_card.name, credit_card.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coefficient_params
      params.require(:coefficient).permit(:condition_id, :quota, :credit_card_id, :start_date, :end_date, :value, :active)
    end
end
