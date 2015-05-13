class AirlinesController < ApplicationController
before_action :set_airline, only: [:show, :edit, :update, :destroy, :clone]    


  # GET /airlines
  # GET /airlines.json
  def index
    @airlines = Airline.all
  end

  # GET /airlines/1
  # GET /airlines/1.json  
  def show
  end

  # GET /airlines/1/edit
  def edit
  end

  def new
    @airline = Airline.new
  end  

  def create
    @airline = Airline.new(airline_params)

    respond_to do |format|
      if @airline.save
        format.html { redirect_to airlines_path, notice: 'La aerolinea fue creada exitosamente.' }
        format.json { render :show, status: :created, location: @airline }
      else
        format.html { render :new }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end   

  # PATCH/PUT /airlines/1
  # PATCH/PUT /airlines/1.json
  def update
    respond_to do |format|
      if @airline.update(airline_params)
        format.html { redirect_to @airline, notice: 'La aerolinea fue actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @bairline }
      else
        format.html { render :edit }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airlines/1
  # DELETE /airlines/1.json
  def destroy
    @airline.destroy
    respond_to do |format|
      format.html { redirect_to airlines_url, notice: 'La aerolinea fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

# POST /airlines/1/clone
  def clone
    @airline = @airline.dup
    respond_to do |format|
      if @airline.save
        @render_hidden_input = true if request.xhr?
        format.html { redirect_to airlines_url, notice: 'La aerolinea fue clonada exitosamente.' }
      else
        format.json { render :json => { :errors => @airline.errors }, :status => 409 }
      end
    end
  end
helper_method :clone  

private
    # Use callbacks to share common setup or constraints between actions.
    def set_airline
        @airline = Airline.find(params[:id])
    end

def airline_params
   params.require(:airline).permit(:name, :max_age_infant, :max_age_child, :iata_code)
end


end
