class ChaptersController < ApplicationController

  def index
    @chapters = Chapter.page(page).per(per_page)
  end

  def show
    @chapter = Chapter.friendly.find(params[:id])
  end

end
