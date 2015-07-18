class ModSubsController < ApplicationController

  def new
    @mod_sub = ModSub.new
    @sub = Sub.find(params[:sub_id])
    render :new
  end

  def create
    input = mod_sub_params
    @sub = Sub.find(params[:sub_id])
    input[:sub_id] = @sub.id
    @mod_sub = ModSub.new(input)
    if @mod_sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @mod_sub.errors.full_messages
      render :new
    end
  end

  def destroy
    @mod_sub = ModSub.find(params[:id])
    if @mod_sub
      @mod_sub.destroy!
    else
      flash[:errors] = @mod_sub.errors.full_messages
    end
    redirect_to sub_url(@mod_sub.sub)
  end

  def mod_sub_params
    params.require(:mod_sub).permit(:username, :sub_id)
  end

end
