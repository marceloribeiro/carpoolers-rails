# frozen_string_literal: true

class CarpoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_chapter

  def index
    @carpools = @chapter.carpools.latest
  end

  def new
    @carpool = Carpool.new
  end

  def create
    @carpool = current_user.carpools.new(
      carpool_params.merge(
        chapter: @chapter,
        frequency: carpool_params[:frequency].to_i
      )
    )
    if @carpool.valid?
      @carpool.save
      redirect_to chapter_carpool_path(@chapter, @carpool),
                  notice: 'Carpool successfully created!'
    else
      render :new
    end
  end

  def show
    @carpool = Carpool.find(params[:id])
  end

  protected

  def find_chapter
    return unless params[:chapter_id].present?
    @chapter = Chapter.friendly.find(params[:chapter_id])
  end

  def carpool_params
    params.require(:carpool).permit(
      :start_location,
      :end_location,
      :start_time,
      :end_time,
      :seats_available,
      :frequency
    )
  end
end
