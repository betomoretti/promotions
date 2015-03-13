class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show, :edit, :destroy]
  before_action :set_airlines, only: [:edit, :new]

  # GET /conditions
  # GET /conditions.json
  def index
    @conditions = Condition.all.order(created_at: :desc)
  end

  # GET /conditions/1
  # GET /conditions/1.json
  def show
    @promotions = @condition.promotions
  end

  # GET /conditions/new
  def new
    @condition = Condition.new
    @condition.save(:validate => false)
    @promotions = []
    @coefficients = []    
  end

  # POST /conditions
  # POST /conditions.json
  def create
    condition_service = ServiceCondition.new(condition_params)
    @condition = condition_service.add_complete_data_to_condition
    respond_to do |format|
      if @condition.save
        format.html { redirect_to @condition, notice: 'La condicion se ha creado con exito.' }
      else
        @airline = Airline.find(condition_params[:airline]) unless condition_params[:airline].blank?
        @airlines = Airline.all.map { |airline| [airline.name, airline.id] }
        @promotions = Promotion.all.where(condition_id: @condition.id)
        format.html { render :new }
      end
    end
  end
  
  # GET /conditions/1/edit
  def edit
    @condition.start_date = @condition.start_date.strftime("%d/%m/%Y") unless @condition.start_date.nil?
    @condition.end_date = @condition.end_date.strftime("%d/%m/%Y") unless @condition.end_date.nil?
    @promotions = @condition.promotions
    @coefficients = @condition.coefficients
    @render_hidden_input = true
  end

  # PATCH/PUT /conditions/1
  # PATCH/PUT /conditions/1.json
  def update
    condition_service = ServiceCondition.new(condition_params)
    @condition = condition_service.add_complete_data_to_condition()
    respond_to do |format|
      if @condition.valid?
        @condition.save
        format.html { redirect_to @condition, notice: 'La condicion se actualizado con exito.' }
      else
        @airline = @condition.airline
        @airlines = Airline.all.map { |airline| [airline.name, airline.id] }
        @promotions = Promotion.all.where(condition_id: @condition.id)
        format.html { render :edit }
      end
    end
  end

  # DELETE /conditions/1
  # DELETE /conditions/1.json
  def destroy
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to conditions_url, notice: 'La condicion ha sido eliminada con exito' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition
      @condition = Condition.find(params[:id])
    end

    def set_airlines
      @airlines = Airline.all.map { |airline| [airline.name, airline.id] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condition_params
      params.require(:condition)
    end
end
