require 'csv'
class CoefficientsController < ApplicationController
  before_action :set_coefficient, only: [:edit, :update, :destroy, :enable, :disable, :clone]
  before_action :set_credit_cards, only: [:new, :edit]

  # GET /coefficients/new
  def new
    @coefficient = Coefficient.new
    @coefficient.start_date = params[:start_date] unless params[:start_date].blank?
    @coefficient.end_date = params[:end_date] unless params[:end_date].blank?
    @coefficient.values = [Value.new(quota: "3"),Value.new(quota: "6"),Value.new(quota: "9"),Value.new(quota: "12")]
    render layout: false
  end

  def export_to_csv
      @coefficients = Coefficient.all
      respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"coefficient-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end   
  end  

  def export_values_to_csv
    @values = Value.all
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"values-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end   
  end  

  
  # GET /coefficients/1/edit
  def edit
    @coefficient.start_date = @coefficient.start_date.strftime("%d/%m/%Y")
    @coefficient.end_date = @coefficient.end_date.strftime("%d/%m/%Y")
    render layout: false
  end

  # POST /coefficients/1/clone
  def clone
    values = @coefficient.values.clone # se deben generar tambien values nuevos, ya que cada value apunta a un ùnico coeficiente
    @coefficient = @coefficient.clone
    @coefficient.values = values
    respond_to do |format|
      if @coefficient.save
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :coefficient => @coefficient, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # POST /coefficients
  # POST /coefficients.json
  def create
    @coefficient = Coefficient.new(coefficient_params)
    @render_hidden_input = true if request.xhr?
    respond_to do |format|
      if @coefficient.save
        format.html { render :partial => "row_table", :locals => { :coefficient => @coefficient, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # PATCH/PUT /coefficients/1
  # PATCH/PUT /coefficients/1.json
  def update
    respond_to do |format|
      if @coefficient.update(coefficient_params)
        format.html { render :partial => "row_table", :locals => {:coefficient => @coefficient} }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # PATCH /coefficients/1/enable
  def enable
    respond_to do |format|
      if @coefficient.update_attribute(:active, true)
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :coefficient => @coefficient, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # PATCH /coefficients/1/disable
  def disable
    respond_to do |format|
      if @coefficient.update_attribute(:active, false)
        @render_hidden_input = true if request.xhr?
        format.html { render :partial => "row_table", :locals => { :coefficient => @coefficient, :render_hidden_input => @render_hidden_input } }
      else
        format.json { render :json => { :errors => @coefficient.errors }, :status => 409 }
      end
    end
  end

  # DELETE /coefficients/1
  # DELETE /coefficients/1.json
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
      params.require(:coefficient).permit(:condition_id, :credit_card_id, :start_date,  :end_date, :active, values_attributes: [:id, :value, :quota, :_destroy])
    end
end