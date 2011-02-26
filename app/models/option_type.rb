require 'ostruct'

class OptionType < Struct.new(:id,:name)
  extend ActiveModel::Naming
  include ActiveModel::Conversion
 
  class << self
    def all(options = {})
      [OptionType.new(:call,'Call'), OptionType.new(:put,'Put')]
    end
  end
  
end
