class AvatarsController < ApplicationController

	before_action :set_listing

  def create
    add_more_avatars(avatars_params[:avatars])
    flash[:error] = "Failed uploading images" unless @listing.save
    redirect_to listing_path(@listing)
  end

  def destroy
    remove_avatar_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @listing.save
    redirect_to listing_path(@listing)
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def add_more_avatars(new_avatars)
    avatars = @listing.avatars # copy the old images 
    avatars += new_avatars # concat old images with new ones
    @listing.avatars = avatars # assign back
  end

  def avatars_params
    params.require(:listing).permit({avatars: []}) # allow nested params as array
  end

end
