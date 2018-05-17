class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :verify, :unverify]

  # GET /listings
  # GET /listings.json
  def index
    # @listings = Listing.all
    @listing = Listing.new
    if signed_in?
      if params[:search]
        @listings = Listing.search(params[:search]).order("created_at DESC")
      else
        if current_user.customer?
          @listings = Listing.where(user_id: current_user.id)
        elsif current_user.moderator?
          @listings = Listing.order("verified asc")
        elsif current_user.superadmin?
          @listings = Listing.all
        else
          flash[:notice] = "Sorry. You are not allowed to perform this action."
          return redirect_to root_url, notice: "Sorry. You do not have the permissino to view the properties."
        end
      end
    else
      redirect_to sign_in_path
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    if allowed?(action: "listing_create", user: current_user)
      @listing = Listing.new
    end
  end

  # GET /listings/1/edit
  def edit
    allowed?(action: "listing_edit", user: @listing.user_id)
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        current_user.listings << @listing
        format.html { redirect_to @listing, :flash => { :success => 'Listing was successfully created.' } }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, :flash => { :success => 'Listing was successfully updated.' } }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    # if allowed?(action: "listing_destroy", user: @listing.user)
      @listing.destroy
      respond_to do |format|
        format.js 
        format.html { redirect_to listings_url, :flash => { :success => 'Listing was successfully destroyed.' } }
        # format.json { head :no_content }
      end
    # end
  end

  # POST /listings/1
  # POST /listings/1.json
  def verify
    if allowed?(action: "listing_verify", user: @listing.user_id)
      if @listing.verified?
        @listing.update(verified: false)
          respond_to do |format|
            format.html { redirect_to listings_url, :flash => { :success => 'Listing was successfully unverified.'}  }
            format.json { render :show, status: :ok, location: @listing }
          end
      else
        @listing.update(verified: true)
          respond_to do |format|
            format.html { redirect_to listings_url, :flash => { :success => 'Listing was successfully verified.'}  }
            format.json { render :show, status: :ok, location: @listing }
          end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, {avatars: []})
    end
end
