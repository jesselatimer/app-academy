class CatRentalRequestsController < ApplicationController
  def new
    @rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(rental_params)
    if @rental_request.save
      redirect_to cat_url(Cat.find(rental_params[:cat_id]))
    else
      render :new
    end
  end

  def approve
    # fail
    @rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @rental_request.approve!
    redirect_to :back
  end

  def deny
    @rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @rental_request.deny!
    redirect_to :back
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end








# def edit
#   @rental_request = CatRentalRequest.find(params[:id])
#   render: :edit
# end
#
# def update
#   @rental_request = CatRentalRequest.find(params[:id])
#   if @rental_request.update(rental_params)
#     redirect_to cat_url(Cat.find(rental_params[:cat_id]))
#   else
#     render :edit
#   end
# end
#
# def destroy
#   @rental_request = CatRentalRequest.find(params[:id])
#   @rental_request.destroy!
#   redirect_to cat_url(Cat.find(rental_params[:cat_id]))
# end
