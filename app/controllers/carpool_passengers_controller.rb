class CarpoolPassengersController < ApplicationController
  before_action :find_carpool_passenger

  def approve
    @carpool_passenger.approved!
    send_to_carpool
  end

  def decline
    @carpool_passenger.declined!
    send_to_carpool
  end

  def send_to_carpool
    redirect_to chapter_carpool_path(
      @carpool_passenger.carpool.chapter,
      @carpool_passenger.carpool
    )
  end

  protected

  def find_carpool_passenger
    @carpool_passenger = CarpoolPassenger.find(params[:id])
    return if current_user == @carpool_passenger.carpool.user
    redirect_to carpool_path(@carpool_passenger.carpool)
  end
end
