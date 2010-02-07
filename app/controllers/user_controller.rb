class UserController < ApplicationController

  before_filter :login_required, :only => [:show, :logout, :wall, :foto]

  def index
    redirect_to :controller => 'feysbook'
  end

  def login
    if request.post?
      @current_user = User.find_by_login_and_password params[:login], Digest::SHA1.hexdigest(params[:password])
      unless @current_user.nil?
        session[:user_id] = @current_user.id
        # dopsat presmerovani na to, co jsem chtel delat
        redirect_to :action => 'show'
        flash[:notice] = 'logged in'
      end
      # flash[:notice] = 'POST'
    else
      flash[:notice] = '!post'
    end
  end

  def logout
    session[:user_id] = @current_user = nil
  end

  def show
    @latest_brick = @current_user.bricks.find :last
  end

  def register
    @user = User.new params[:register]
    if request.post? and @user.save
      session[:user_id] = @user.id
      redirect_to :controller => 'user', :action => 'show'
    end
  end

  def wall
    @latest_bricks = @current_user.bricks.find :all, :order => 'created_at desc', :limit => 8
  end

  def foto
  end

  def newbrick
    @brick = Brick.new params[:brick]
    @brick.user_id = @current_user.id
    if request.post? and @brick.save
      redirect_to :action => 'wall'
    end
  end

end
