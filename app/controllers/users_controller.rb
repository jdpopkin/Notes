class UsersController < ApplicationController
  # before_filter :require_current_user!, :only => [:show]
  before_filter :require_no_current_user!, :only => [:create, :new]

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to root_url # TODO change this link
    else
      render :json => @user.errors, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
      render :show
    else
      redirect_to :back # TODO change this link
    end
  end
end
