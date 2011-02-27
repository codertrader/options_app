class Memo

  class << self

    ABOUT_ME = <<-ABOUT_ME
    This is a long description about me.  Since it does not fit well in a single
    line of code, I thought it would be best to give myself more room to go on and
    on about a lot of things that most people don't care about.
    ABOUT_ME

    THE_POINT = <<-THE_POINT
    Does there really have to be a point, other than for the love of the code?
    Everyone is searching for the best opportunity or silver bullet to come by,
    that once found, will greatly improve everyone's life or enjoyment of life.
    The fact is, that is the holy grail, that which cannot be found.  Therefore,
    one can only attempt to find true happiness by searching within themselves.
    I create software to create and to leave a mark on the world.  If I have touched
    even one person, including myself, then it has been all worth it.
    THE_POINT

    def all
      all = []
      all << Memo.new(:title=>"About::Me", :short=>"Short summary of who I am and what I do.", :long=>ABOUT_ME, :created_date_as_text=>'February 27, 2011')
      all << Memo.new(:title=>"Whats the Point?", :short=>"Why was this piece of software built?", :long=>THE_POINT, :created_date_as_text=>'February 27, 2011')
      all
    end
  end

  # concise attribute names
  attr_accessor :title, :short, :long, :created_date_as_text

  # more descriptive names for the same thing
  alias_method :short_description, :short
  alias_method :long_description, :long

  def initialize( params )
    self.title = params[:title]
    self.short = params[:short]
    self.long  = params[:long]
    self.created_date_as_text = params[:created_date_as_text]
  end

end

