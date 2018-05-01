class HomeController < ApplicationController
  include Clearance::Controller
  protect_from_forgery with: :exception

  def home
  	@lists = Listing.page(params[:page])

  end

  def search
  	@listings = Listing.ransack(params[:q]).result(disctint:true)
  	respond_to do |format| 
  	    format.html {}
  	    format.json {
  	        @listings = @listings.all
  	}
  end
  end
end
