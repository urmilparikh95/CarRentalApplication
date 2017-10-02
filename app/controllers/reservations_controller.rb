class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update]
  before_action :set_car,:set_user, only: [:new, :create]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @car.status = "reserved"
    @reservation.car_id = @car.id
    @reservation.user_id = @user.id
    @reservation.status = "current"
    @reservation.rental_charge = ((@reservation.to - @reservation.from) / 3600.0).round * @car.hourly_rate

    respond_to do |format|
      if @reservation.save && @car.save
        format.html { redirect_to @car, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @current_reservation = user_reservation
    @current_car = Car.find(@reservation.car_id)
    @car_status = "available"
    if @current_reservation.destroy and @current_car.update(:status => @car_status)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Reservation was successfully cancelled.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_car
      @car = Car.find(params[:car_id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:id , :from, :to)
    end
end
