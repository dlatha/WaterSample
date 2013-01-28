require 'spec_helper'
require_relative '../models/sample_spec_helper'

describe SamplesController do
  include SampleSpecHelper
  
  before(:each) do
  @sample1 = Sample.create! valid_sample_attributes
  
  @factor = Factor.create! valid_factor_attributes
  
  end
  
  it "should return invalid for invalid factor_id" do
    @message = SamplesController.new.factor(8,1)
    @message.should == "Invalid Value"
    @message = SamplesController.new.factor(2.2,1)
    @message.should == "Invalid Value"
    @message = SamplesController.new.factor(-1,1)
    @message.should == "Invalid Value"
    
  end
  
  it "should return valid factor for a valid factor_id" do
    @message = SamplesController.new.factor(1,1)
    @message.should == 0
    @message = SamplesController.new.factor(2,1)
    @message.should == 0.7
    @message = SamplesController.new.factor(3,1)
    @message.should == 0.4
    @message = SamplesController.new.factor(4,1)
    @message.should == 1.1
  end
  
  
  it "should return a message after analysis" do
    sc = SamplesController.new
    @message = sc.analysis(1)
    @message.nil?
  end
  
  it "should return severity of level 1  if the trihalomethanes exceed 0.08" do
  @sample1 = Sample.create! valid_bad1_attributes
  @factor = Factor.create! valid_factor_attributes
  sc = SamplesController.new
  @message,@severity = sc.analysis(2)
  @message.should == "Your water has Nasty Chemicals.It exceeds EPA regulation for trihalomethanes."
  @severity.should == 1
  end

  it "should return severity of level 2  if the chlorodibromide and bromoform are high but do not exceed 0.08" do
   @sample2 = Sample.create! valid_bromochloro2_attributes
   @factor = Factor.create! valid_factor_attributes
   sc = SamplesController.new
   @message,@severity = sc.analysis(2)
   @message.should == "Your water has dangerous trihalomethanes. We suggest you use a filter that can filter out bromoform and chlorodibromide."
   @severity.should == 2
   end

   it "should return severity of level 3  if bromoform is high but do not exceed 0.08" do
    @sample3 = Sample.create! valid_bromo3_attributes
    @factor = Factor.create! valid_factor_attributes
    sc = SamplesController.new
    @message,@severity = sc.analysis(2)
    @message.should == "Your water has dangerous trihalomethanes. We suggest you use a filter that can filter out bromoform."
    @severity.should == 3
    end
    
    it "should return severity of level 4  if the chlorodibromide is high but do not exceed 0.08" do
     @sample4 = Sample.create! valid_chloro4_attributes
     @factor = Factor.create! valid_factor_attributes
     sc = SamplesController.new
     @message,@severity = sc.analysis(2)
     @message.should == "Your water has dangerous trihalomethanes. We suggest you use a filter that can filter out chlorodibromide."
     @severity.should == 4
     end
     
     it "should return severity of level 5  if trihalomethanes do not exceed 0.08" do
      @sample5 = Sample.create! valid_sample_attributes
      @factor = Factor.create! valid_factor_attributes
      sc = SamplesController.new
      @message,@severity = sc.analysis(2)
      @message.should == "Your Water is Safe! :)"
      @severity.should == 5
      end

end
