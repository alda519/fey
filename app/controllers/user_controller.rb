class UserController < ApplicationController

  before_filter :login_required, :only => [:show, :logout, :wall, :avatar, :newavatar, :foto, :edit]

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

  def avatar
    if params[:id].blank?
      num = @current_user.id
    else
      num = params[:id]
    end
    if FileTest.exists?("#{RAILS_ROOT}/lib/avatar-#{num}.png")
      send_file "#{RAILS_ROOT}/lib/avatar-#{num}.png", :type=>'image/png', :disposition=>'inline'
    else
      send_file "#{RAILS_ROOT}/public/images/cow_small.png", :type => 'image/png', :disposition => 'inline'
    end
  end

  def newavatar
    if request.post? and ! params[:upload][:datafile].blank?
      name = params[:upload][:datafile].original_filename
      directory = "#{RAILS_ROOT}/lib/tmp"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:upload][:datafile].read) }
      `convert #{RAILS_ROOT}/lib/tmp/#{name} -resize 80x80 #{RAILS_ROOT}/lib/avatar-#{@current_user.id}.png`
      #`rm #{RAILS_ROOT}/lib/tmp/#{name}` 
       redirect_to :action => 'show'
#      send_data params[:upload][:datafile].read, :disposition => 'inline'
    end
  end

  def edit
    @user = User.find_by_id @current_user.id
    if request.post?
      @user.attributes = params[:user]
      if @user.save
        redirect_to :action => 'index'
      else
        @user = User.new params[:user]
      end
    else
      @user.password = ''
    end
  end

end
