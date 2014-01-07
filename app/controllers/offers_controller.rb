class OffersController < ApplicationController
  before_filter :secure_page

  rescue_from ActiveRecord::RecordNotFound do
    flash[:correct] = 'Aanbieding bestaat niet meer!'
    redirect_to events_all_url
  end

  def index
  @user = current_user
  @offers = Offer.within((@user.radius.to_f/1000).to_f, :origin => @user ).where(:offer_type =>'offers').search(params[:search])
  end

  def show
   @user = current_user
   @offer = Offer.find(params[:id],:conditions =>["offer_type = ?", "offers" ])
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user_id =  current_user.id

    if @offer.save
      flash[:notice] = 'Aanbieding is succesvol geplaatst!'
      upload_image(params, @offer)
      redirect_to @offer
    else
       redirect_to cookies[:lastpage]
    end
  end

  def new
    @offer = Offer.new
    @user = current_user
  end

  def delete_offer
    @offer = Offer.find(params[:id])

    if  @offer.delete
      flash[:correct] = 'Aanbieding is verwijderd!'
      redirect_to offers_all_url
    end
  end


  private
  def offer_params
    params.permit(:title, :message, :user_id, :longitude, :offer_type ,:latitude, :fulfilled)
  end

  def upload_image(upload, offer)
    unless upload['datafile'].nil?
      image_root = 'public/images/offers/'

      if File.exist?(image_root + offer.id.to_s + ".png")
        File.delete(image_root + offer.id.to_s + ".png")
      end

      if File.exist?(image_root + offer.id.to_s + ".jpg")
        File.delete(image_root + offer.id.to_s + ".jpg")
      end

      if File.exist?(image_root + offer.id.to_s + ".jpeg")
        File.delete(image_root + offer.id.to_s + ".jpeg")
      end

      file_name = upload['datafile'].original_filename  if  (upload['datafile'] !='')
      file = upload['datafile'].read

      file_type = file_name.split('.').last
      new_name_file = offer.id

      new_file_name_with_type = "#{image_root}#{new_name_file}." + file_type

      File.open(new_file_name_with_type, "wb")  do |f|
        f.write(file)
      end
    end
  end
end
