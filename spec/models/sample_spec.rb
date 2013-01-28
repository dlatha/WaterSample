require 'spec_helper'

describe Sample do
  include SampleSpecHelper
  
  before(:each) do
  @sample = Sample.create! valid_sample_attributes
  end
  
  it "Location should not be nil" do
    @sample.location.nil?   
  end
  
  it "The trihalomethanes qty should be a Decimal number" do
    
    @sample.chloroform.should be_kind_of(Float)
    @sample.bromoform.should be_kind_of(Float)
    @sample.dichlorobromide.should be_kind_of(Float)
    @sample.chlorodibromide.should be_kind_of(Float)
  end
  
end
