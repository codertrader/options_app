class OptionModelsController < ApplicationController
  # GET /options
  # GET /options.xml
  def index
    @options = OptionModel.all
    @option = OptionModel.new

    if( session[:option_model] )
      @option = OptionModel.new(session[:option_model])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @options }
    end
  end

  # GET /options/new
  # GET /options/new.xml
  def new
    @option = OptionModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option }
    end
  end


  # POST /options
  # POST /options.xml
  def create
    @option = OptionModel.new(params[:option_model])

    saved = @option.save
    session[:option_model] = @option.to_hash

    respond_to do |format|
      if saved
        format.html { redirect_to(@option) }
        format.xml  { render :xml => @option, :status => :created, :location => @option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

end
