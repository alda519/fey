class WallController < ApplicationController

  before_filter :login_required

  def index
    if params[:id].blank? or params[:id].to_i < 1
      @current_page = 1
    else
      @current_page = params[:id].to_i
    end

    @latest_bricks = @current_user.bricks.find :all, :order => 'created_at desc', :limit => "#{(@current_page - 1) * 8}, 8"
    @pages = (@current_user.bricks_count / 8.0).ceil
    @enemies = User.find :all, :order => 'rand()', :conditions => "id != #{@current_user.id}", :limit => 8
    session[:page] = 'wall'
  end

  def newbrick
    @brick = Brick.new params[:brick]
    @brick.user_id = @current_user.id
    if request.post? and @brick.save
      redirect_to :action => 'index'
    end
  end

  def delete
    #@brick = Brick.find_by_id_and_user_id params[:id], @current_user.id
    @brick = @current_user.bricks.find_by_id params[:id]
    unless @brick.blank?
      @brick.destroy #delete
    else
      flash[:warning] = 'Tento nejde smazat'
    end
    redirect_to :controller => session[:page]
  end

  def edit
    @brick = Brick.find_by_id_and_user_id params[:id], @current_user.id
    if request.post?
      @brick.attributes= params[:brick]
      if @brick.save
         redirect_to :action => 'index'
      else
        @brick = Brick.new params[:brick]
      end
    else
      redirect_to :action => 'index' if @brick.blank?
    end
  end

end
