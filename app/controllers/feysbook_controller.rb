class FeysbookController < ApplicationController

  def index
    unless logged_in?
      redirect_to :controller => 'user', :action => 'register'
    end
  end

end
