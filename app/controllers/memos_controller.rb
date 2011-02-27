class MemosController < ApplicationController

  def index
    @memos = Memo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memos }
    end
  end

  def show
    @memo = Memo.find(params[:title])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @option }
    end
  end

end