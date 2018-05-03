class HomeController < ApplicationController
  include Clearance::Controller
  protect_from_forgery with: :exception

  def home
    @listings = Listing.select(:verified).page(params[:page])

  	@lists = Listing.order(:verified).page(params[:page])
  end

  def search
  	@listings = Listing.ransack(params[:q]).result(distinct: true)

    respond_to do |format|
	    format.json {
	        @listings = @listings.limit(10)
  	}
    end
  end

end