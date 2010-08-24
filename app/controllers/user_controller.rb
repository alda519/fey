require 'RMagick'

class UserController < ApplicationController

  before_filter :login_required, :only => [:show, :logout, :wall, :avatar, :newavatar, :foto, :edit]

  def index
    redirect_to :action => 'show'
  end

  def login
    if request.post? # jestli byl poslan pozadavek na login
      @current_user = User.find_by_login_and_password params[:user][:login], Digest::SHA1.hexdigest(params[:user][:password])
      unless @current_user.nil?
        session[:user_id] = @current_user.id
        # dopsat presmerovani na to, co jsem chtel delat
        redirect_to :action => 'show'
        #flash[:notice] = nil #"Byl jsi úspěšně přihlášen.".encoding
        flash[:notice] = "Prihlaseni OK"
      else
        flash[:error] = "Neexistujici uzivatel nebo chybne heslo" #"Neexistující uživatel nebo chybné heslo."
        @user = User.new params[:user]
        @user.password = ''
      end
    end
  end

  def logout
    session[:user_id] = @current_user = nil
    flash[:notice] = "Byl jsi odhlasen"
    redirect_to :action => 'login'
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
    flash[:warning] = "Jeste to nemam hotovy"
    flash.discard
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
      name = "tmp-#{@current_user.id}" ; directory = "#{RAILS_ROOT}/lib" ; path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:upload][:datafile].read) }
      begin
        img_orig = Magick::Image.read(path).first
        img_orig.resize_to_fill(80,80).write "#{directory}/avatar-#{@current_user.id}.png"
      rescue
      end
      File.delete(path)
      redirect_to :action => 'show'
    end
  end

  def edit
    @user = @current_user
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
