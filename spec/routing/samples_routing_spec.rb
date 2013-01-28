require 'spec_helper'

describe SamplesController do
  describe "routing" do
    
    it "routes to #edit" do
      get("/samples/1/test").should route_to("samples#test", :sample_id => "1")
    end
    
  end
end