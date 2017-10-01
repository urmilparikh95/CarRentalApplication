class Admin::CarsController < Admin::AdminController
  before_action :set_car, only: [:show, :edit, :update, :destroy, :checkout_history]

  # GET admin/cars
  # GET admin/cars.json
  def index
    @cars = Car.all
  end

  # GET admin/cars/1
  # GET admin/cars/1.json
  def show
  end

  # GET admin/cars/1/checkout_history
  # GET admin/cars/1/checkout_history.json
  def checkout_history
    @reservations = @car.reservations
  end

  # GET admin/cars/new
  def new
    @car = Car.new
  end

  # GET admin/cars/1/edit
  def edit
  end

  # POST admin/cars
  # POST admin/cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/cars/1
  # PATCH/PUT admin/cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to admin_cars_path, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/cars/1
  # DELETE admin/cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:licence_no, :manufacturer, :model, :style, :hourly_rate, :location, :status)
    end
end
