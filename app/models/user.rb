class User < ActiveRecord::Base

  has_secure_password

  belongs_to  :country, :foreign_key => 'country'
  has_many :authentications
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'to_user'
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'from_user'
  has_many :offers
  has_many :demands, :class_name => 'Offer', :foreign_key => 'user_id', :dependent => :destroy, :conditions => {:offer_type => 'demand'}
  has_many :supplies, :class_name => 'Offer', :foreign_key => 'user_id', :dependent => :destroy, :conditions => {:offer_type => 'supply'}

  has_many :reactions, :foreign_key => 'id'
  has_many :unread_messages, :class_name => 'Message', :foreign_key => 'to_user', :conditions => {:read => false}

  before_create {
    self.email = email.downcase
    if self.latitude.blank? && self.longitude.blank?
      self.latitude = 51.985103;
      self.longitude = 5.898730;
    end
    if self.radius.blank?
      self.radius = 500;
    end
  }

  before_update {
    if self.adres_changed? || self.zipcode_changed? || self.place_changed?
      Rails.logger.debug 'before update jonge'
      nl_bounds = Geokit::Geocoders::Google3Geocoder.geocode('Nederland').suggested_bounds
      res = Geokit::Geocoders::Google3Geocoder.geocode(self.adres+' '+self.zipcode+' '+self.place, :bias => nl_bounds)
      self.latitude = res.lat
      self.longitude = res.lng
    end
  }

  before_create :create_remember_me_token

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def User.new_remember_me_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s);
  end

  def add_provider(auth)
    unless authentications.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Authentication.create :user => self, :provider => auth["provider"], :uid => auth["uid"]
    end
  end

  def self.near_user
    User.within(5, :origin => [51.987743, 5.950249]);
  end

  private
  def create_remember_me_token
    self.remember_token = User.encrypt(User.new_remember_me_token);
  end

end
