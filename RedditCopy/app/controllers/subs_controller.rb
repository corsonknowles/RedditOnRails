class SubsController < ApplicationController

before_action :require_logged_in

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
  end

  def new
    @sub = Sub.new
  end

  def destroy
    @sub = current_user.subs.find(params[:id])
    if @sub
      @sub.destroy
      redirect_to subs_url
    else
      flash[:errors] = ['not yo sub']
      redirect_to subs_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
