require 'ostruct'

Association = Struct.new(:klass, :name, :macro, :options)
Column = Struct.new(:name,:type)

class OptionModel 
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Serialization
  include ActiveModel::Conversion
 
  class << self
    def all; []; end
    def find(param); nil; end
    
    def reflect_on_association(association)
      case association
        when :option_type
          Association.new(OptionType, association, :belongs_to, {})
      end
    end
  end

  validates_presence_of :underlying, :strike, :time, :sigma, :dividend, :interest

  # inputs
  attr_accessor :symbol, :option_type_id, :underlying, :strike, :time, :sigma, :dividend, :interest, :target_price

  # outputs
  attr_accessor :price, :delta, :gamma, :vega, :id

  def initialize( params = {} )
    self.symbol = params[:symbol]
    self.option_type_id = params[:option_type_id] || :call
    self.underlying = params[:underlying].to_f
    self.strike = params[:strike].to_f
    self.time = params[:time].to_f
    self.sigma = params[:sigma].to_f
    self.dividend = params[:dividend].to_f
    self.interest = params[:interest].to_f
    self.target_price = params[:target_price].to_f

    self.price = params[:price].to_f
    self.delta = params[:delta].to_f
    self.gamma = params[:gamma].to_f
    self.vega = params[:vega].to_f
  end

  def save
    calc
  rescue Exception  => any_exception
    ::Rails.logger.warn any_exception  
  end

  def as_option_model 
    # Construct an Option::Model from the thin Parameters model
    option = Option::Model.new( self.option_type_id.to_sym )
    
    option.underlying = self.underlying
    option.strike = self.strike
    option.time = self.time
    option.sigma = self.sigma
    option.dividend = self.dividend
    option.interest = self.interest

    option
  end

  def calc_implied_vol
    as_option_model.calc_implied_vol( self.target_price )
  end

  def calc
    option = as_option_model
    self.price = option.calc_price
    self.delta = option.calc_delta
    self.gamma = option.calc_gamma
    self.vega  = option.calc_vega
    self.id = 1
  end

  def to_hash    
     {:underlying => self.underlying,
      :option_type_id => self.option_type_id,
      :strike => self.strike,
      :time => self.time,
      :sigma => self.sigma,
      :dividend => self.dividend,
      :interest => self.interest,
      :symbol => self.symbol,
      :price => self.price,
      :delta => self.delta,
      :gamma => self.gamma,
      :vega => self.vega}
  end

  def to_key
    [self.id]
  end

  def persisted?
    false
  end
  
  def column_for_attribute(attribute)
    case(attribute)
      when /symbol/
        Column.new(attribute,:string)
      else
        Column.new(attribute,:numeric)
    end
  end

end
