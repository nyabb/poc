class Reaction < ActiveRecord::Base
  belongs_to :user, :foreign_key => 'userId'
  belongs_to :offer, :foreign_key => "id", :conditions => {:react_type => "offers"}

def self.will_paginate(page)

    paginate :per_page => 5, :page => page

end
end