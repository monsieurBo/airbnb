class HomeController < ApplicationController
  include Clearance::Controller
  protect_from_forgery with: :exception

  def home
    @listings = Listing.select(:verified).page(params[:page])

  	@lists = Listing.order(:verified).page(params[:page])
  end

  def search
  	@lists = Listing.search_country(params[:search])
    @listings = Listing.search(params[:search])

    respond_to do |format|
      format.html 
      format.json { render json: @lists }
      # format.js { render :layout => false  }
    end
  end

end