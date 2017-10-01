class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :set_current_car, only: [:edit, :update]
  before_action :set_user, only: [:show, :index]

  # GET /cars
  # GET /cars.json
  def index
    if !params[:query]
      @cars = Car.all
    else
      @cars = Car.where("#{params[:status].to_sym} ilike ?", "%#{params[:query].to_s}%")
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @current_car.reserved?
        @car_status = "checked_out"
        @reservation_stattus = "current"
        @message = 'Car was successfully checked out.'
      else
        @car_status = "available"
        @reservation_stattus = "past"
        @message = 'Car was successfully returned.'
      end
      if @current_car.update(:status => @car_status) && @reservation.update(:status => @reservation_stattus)
        format.html { redirect_to root_path, notice: @message }
        format.json { render :show, status: :ok, location: @current_car }
      else
        format.html { render :edit }
        format.json { render json: @current_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_current_car
      @reservation = user_reservation
      @current_car = Car.find(@reservation.car_id)
    end

    def set_user
      @user = current_user
    end
end
