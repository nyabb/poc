class Offer < ActiveRecord::Base

  belongs_to :user
  has_many   :reactions, :foreign_key => "react_to",  :dependent => :destroy

  acts_as_mappable    :default_units => :kms,
                      :default_formula => :sphere,
                      :lat_column_name => :latitude,
                      :lng_column_name => :longitude

  validates :title, presence: true
  validates :message, presence: true

  def self.search(search)
    if search
      find(:all, :conditions => ['message LIKE ? OR title LIKE ?' , "%#{search}%"  , "%#{search}%"])
    else
      find(:all)
    end
  end

end
