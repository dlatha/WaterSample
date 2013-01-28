module SampleSpecHelper
  def valid_sample_attributes
    {  
      :location => "LA Aquaduct Filteration Plant Effluent",
      :chloroform => 0.00071,
      :bromoform => 0.00017,
      :chlorodibromide => 0.00001,
      :dichlorobromide => 0.00116 }
  end
  def valid_factor_attributes
    { :factor1 => 0.0,
      :factor2 => 0.7,
      :factor3 => 0.4,
      :factor4 => 1.1 }
  end
  def valid_bromo3_attributes
    {
      :location => "LA Aquaduct Filteration Plant Effluent",
      :chloroform => 0.00104,
      :bromoform => 0.065,
      :chlorodibromide => 0.0,
      :dichlorobromide => 0.002 }
  end
  def valid_chloro4_attributes
    {
      :location => "LA Aquaduct Filteration Plant Effluent",
      :chloroform => 0.00104,
      :bromoform => 0.0,
      :chlorodibromide => 0.09,
      :dichlorobromide => 0.00275 }
  end
  def valid_bromochloro2_attributes
    {
      :location => "LA Aquaduct Filteration Plant Effluent",
      :chloroform => 0.00104,
      :bromoform => 0.0056,
      :chlorodibromide => 0.002,
      :dichlorobromide => 0.00275 }
  end
  def valid_bad1_attributes
    {
      :location => "LA Aquaduct Filteration Plant Effluent",
      :chloroform => 0.00065,
      :bromoform => 0.168,
      :chlorodibromide => 0.0013,
      :dichlorobromide => 0.00428 }
  end
end