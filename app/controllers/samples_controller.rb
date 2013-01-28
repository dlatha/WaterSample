class SamplesController < ApplicationController
  def index
    @samples = Sample.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @samples }
    end
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample }
    end
  end

  # GET /samples/new
  # GET /samples/new.json
  def new
    @sample = Sample.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample }
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = Sample.find(params[:id])
  end

  # POST /samples
  # POST /samples.json
  def create
    @sample = Sample.new(params[:sample])

    respond_to do |format|
      if @sample.save
        format.html { redirect_to @sample, notice: 'Sample was successfully created.' }
        format.json { render json: @sample, status: :created, location: @sample }
      else
        format.html { render action: "new" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.json
  def update
    @sample = Sample.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        format.html { redirect_to @sample, notice: 'Sample was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.json
  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to samples_url }
      format.json { head :no_content }
    end
  end

  def test
    @message,@severity = analysis(params[:sample_id])
  end
  
  def analysis(sample_id)
    @sample = Sample.find(sample_id)
    @factor =Factor.find(@sample)
    case
    when @sample.chloroform.nil?
      @trihalo_total =  @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3 + @sample.dichlorobromide * @factor.factor4 
      @nasty = @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3
      @non_nasty =  @sample.dichlorobromide * @factor.factor4
    when @sample.bromoform.nil?
      @trihalo_total = @sample.chloroform * @factor.factor1 +  @sample.chlorodibromide * @factor.factor3 + @sample.dichlorobromide * @factor.factor4 
      @nasty = @sample.chlorodibromide * @factor.factor3
      @non_nasty = @sample.chloroform * @factor.factor1 + @sample.dichlorobromide * @factor.factor4
    when @sample.chlorodibromide.nil?
      @trihalo_total = @sample.chloroform * @factor.factor1 + @sample.bromoform * @factor.factor2  + @sample.dichlorobromide * @factor.factor4 
      @nasty = @sample.bromoform * @factor.factor2
      @non_nasty = @sample.chloroform * @factor.factor1 + @sample.dichlorobromide * @factor.factor4
    when @sample.dichlorobromide.nil?
      @trihalo_total = @sample.chloroform * @factor.factor1 + @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3 
      @nasty = @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3
      @non_nasty = @sample.chloroform * @factor.factor1
    else
      @trihalo_total = @sample.chloroform * @factor.factor1 + @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3 + @sample.dichlorobromide * @factor.factor4 
      @non_nasty = @sample.chloroform * @factor.factor1 + @sample.dichlorobromide * @factor.factor4
      @nasty = @sample.bromoform * @factor.factor2 + @sample.chlorodibromide * @factor.factor3
    end
    
    case
      when @trihalo_total > 0.08
        @message,@severity = "Your water has Nasty Chemicals.It exceeds EPA regulation for trihalomethanes.", 1
      when @nasty > @non_nasty && @trihalo_total < 0.08
            @message = "Your water has dangerous trihalomethanes. We suggest you use a filter that can filter out "
              case
              when @sample.bromoform == 0
                  @message,@severity = @message + "chlorodibromide.",4
          
              when @sample.chlorodibromide == 0
                  @message,@severity = @message + "bromoform.",3
              else
                  @message,@severity = @message + "bromoform and chlorodibromide.",2
              end
      else
            @message,@severity = "Your Water is Safe! :)",5
    end
    
  end
  
  def factor(factor_id,sample_id)
      @sample = Sample.find(sample_id)
      @factors = Factor.find(@sample).attributes.to_hash
      @factors = @factors.select{|key,value| hash= key.match(/factor\d/)}.values
      case 
      when factor_id < 0
        p "Invalid Value"
      when factor_id.class == Float
        p "Invalid Value"
      when factor_id > @factors.length
        p "Invalid Value"
      else
        p @factors[factor_id-1]
      end
   end
   
  
end
