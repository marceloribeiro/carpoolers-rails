# frozen_string_literal: true

class ChaptersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @chapters = Chapter.page(page).per(per_page)
    @nearby = @chapters.near(current_location) if current_location.present?
  end

  def new
    @chapter = Chapter.new
  end

  def show
    @chapter = Chapter.friendly.find(params[:id])
  end

  def create
    @chapter = current_user.chapters.new(chapter_params)
    if @chapter.valid?
      @chapter.save
      redirect_to chapters_path
    else
      render :new
    end
  end

  protected

  def chapter_params
    params.require(:chapter).permit(:name)
  end
end
