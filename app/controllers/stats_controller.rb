class StatsController < ApplicationController

  def index
    @users = User.count
    @bricks = Brick.count
  end

end
