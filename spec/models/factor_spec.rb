require 'spec_helper'

describe Factor do
  include SampleSpecHelper
  before(:each) do
  @factor = Factor.create! valid_factor_attributes
  @sample = Sample.create! valid_sample_attributes
  end
  
  it "None of the factors should should not be nil" do
      @factor.factor1.nil?
      @factor.factor2.nil?
      @factor.factor3.nil?
      @factor.factor4.nil?   
  end
  
  it "The data type of factors entered should match corresponding sample data types" do
    
    @sample.chloroform.should be_kind_of(@factor.factor1.class)
    @sample.bromoform.should be_kind_of(@factor.factor2.class)
    @sample.dichlorobromide.should be_kind_of(@factor.factor3.class)
    @sample.chlorodibromide.should be_kind_of(@factor.factor4.class)
  end
end
