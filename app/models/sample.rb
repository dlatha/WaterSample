class Sample < ActiveRecord::Base
  attr_accessible :bromoform, :chlorodibromide, :chloroform, :dichlorobromide, :location
  has_one :factors
end
