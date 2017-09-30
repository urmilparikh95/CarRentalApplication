class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :index]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  def customer_home
    if !params[:query]
      @cars = Car.all
    else
      @cars = Car.where("#{params[:status].to_sym} like ?", "%#{params[:query].to_s}%")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_user
      @user = current_user
    end
end
