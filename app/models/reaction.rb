class Reaction < ActiveRecord::Base
  belongs_to :user, :foreign_key => 'userId'
  belongs_to :offer, :foreign_key => "id", :conditions => {:react_type => "offers"}
end
def self.search(search,page)
  if search
    paginate :per_page => 5, :page => page
  end
end