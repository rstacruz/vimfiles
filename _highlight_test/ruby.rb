class MyClass < ApplicationController
  include EventManager

  before_filter :authenticate_user!

  # Returns something t osomeone
  def index
    @var = User.find(params[:affiliate_program_id])
    @affiliate = Affiliate.new
  end
end

