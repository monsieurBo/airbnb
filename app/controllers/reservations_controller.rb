class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :accept, :reject]

  # GET /reservations
  # GET /reservations.json
  def index
    if signed_in?
      if params[:search]
        @listings = Listing.search(params[:search]).order("created_at DESC")
      else
        if current_user.customer?
          @reservations = Reservation.where(user_id: current_user.id)
        elsif current_user.moderator?
          @reservations = Reservation.all
        elsif current_user.superadmin?
          @reservations = Reservation.all
        else
          flash[:notice] = "Sorry. You are not allowed to perform this action."
          return redirect_to root_url, notice: "Sorry. You do not have the permissino to view the properties."
        end
      end
    else
      redirect_to sign_in_path
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    p params
    @reservation.user_id = current_user.id
    @reservation.listing_id = params[:listing_id]
    if date_checker(@reservation.start_date, @reservation.end_date)
      if @reservation.save
        redirect_to @reservation , notice: 'Reservation was successfully created.'
      else
        @listing = Listing.find(@reservation.listing_id)
        render :new
      end
    end
  
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    @reservation.update(accepted: true)
    render @show, notice: 'Reservation is accepted'
  end

  def reject
    @reservation.update(accepted: false)
    render @show, notice: 'Reservation is rejected'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date, :guest_number, :verified)
    end

    def date_checker(start_date, end_date)
      @reservations = Reservation.where(listing_id: params[:listing_id])
      if @reservations
        @reservations.each do |r|
          # if (start_date >= r.start_date && end_date <= r.end_date) || (start_date < r.end_date && end_date > r.end_date) || (start_date < r.start_date && end_date >= r.start_date)
          if (start_date < r.end_date && end_date > r.start_date)
             @listing = Listing.find(@reservation.listing_id)

            flash[:alert] = "Alerting you to the monkey on your car!"
            render :new
            return false
          end
        end
      else
        return true
      end
    end

end
