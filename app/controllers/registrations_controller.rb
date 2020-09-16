class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      flash[:notice] = "Thank you for registering!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:player_first_name, :player_last_name,
      :parent_first_name, :parent_last_name, :email, :grade_level,
      :graduation_year, :need_uniform, :uniform_jersey_size, :uniform_short_size)
  end

end
