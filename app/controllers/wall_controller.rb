class WallController < ApplicationController

  before_filter :login_required

  def index
    @latest_bricks = @current_user.bricks.find :all, :order => 'created_at desc', :limit => 8
    session[:page] = 'wall'
    @enemies = User.find :all, :order => 'rand()', :conditions => "id != #{@current_user.id}", :limit => 8
  end

  def newbrick
    @brick = Brick.new params[:brick]
    @brick.user_id = @current_user.id
    if request.post? and @brick.save
      redirect_to :action => 'index'
    end
  end

  def delete
    @brick = Brick.find_by_id params[:id]
    if @brick.user_id == @current_user.id
      @brick.delete
    else
      flash[:warning] = 'Tento nejde smazat'
    end
      redirect_to :controller => session[:page]
  end

  def edit

  end


end
