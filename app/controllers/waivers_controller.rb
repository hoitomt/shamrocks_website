class WaiversController < ApplicationController
  def index
    # Not a true index method - just a display of a blank waiver.
  end

  def new
    @registration = Registration.find(params[:registration_id])
    @waiver = Waiver.new
  end

  def create
    @waiver = Waiver.new(waiver_params)
    if @waiver.save
      flash[:notice] = "Thank you for signing the waiver"
      redirect_to root_path
    else
      flash.now[:alert] = "Please confirm that you have read the waiver"
      @registration = Registration.find(waiver_params[:registration_id])
      render :new
    end
  end

  private
  def waiver_params
    params.require(:waiver).permit(:registration_id, :confirmation)
  end
end
