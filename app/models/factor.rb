class Factor < ActiveRecord::Base
  attr_accessible :factor1, :factor2, :factor3, :factor4
  has_one :samples
  belongs_to :samples
end
