class UserController < ApplicationController

  before_filter :login_required, :only => [:show, :logout, :wall, :foto]

  def index
    redirect_to :action => 'show'
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

  def register
    @user = User.new params[:user]
    if request.post? and @user.save
      session[:user_id] = @user.id
      redirect_to :action => 'show'
    end
  end


  def show
    @latest_brick = @current_user.bricks.find :last
    session[:page] = 'user'
  end

  def wall
    redirect_to :controller => 'wall'
  end

  def foto
  end

end
