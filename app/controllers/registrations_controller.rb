class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    # This is primarily to verify that the grade level is present.
    # But also, there isn't any point in continuing if the other fields aren't valid
    unless @registration.valid?
      render :new and return
    end

    grade_level_cost = @registration.calculate_grade_level_cost

    @registration.amount = grade_level_cost unless grade_level_cost.nil?

    payment_processed = process_payment(params[:stripeToken], @registration)
    unless payment_processed
      flash[:alert] = @stripe_error_message
      render :new and return
    end
    @registration.charge_identifier = @charge.id

    if @registration.save
      RegistrationMailer.confirmation(@registration).deliver_now
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

  # Token is created using Stripe Checkout or Elements!
  # Get the payment token ID submitted by the form
  def process_payment(stripe_token, registration)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    charge_details = {
      "email" => "#{registration.email}",
      "parent_name" => "#{registration.parent_name}",
      "grade_level" => "#{registration.grade_level}",
      "amount" => "$#{registration.amount}",
      "jersey" => "$#{registration.uniform_jersey_size}",
      "short" => "$#{registration.uniform_short_size}"
    }

    begin
      @charge = Stripe::Charge.create({
        amount: (registration.amount * 100).to_i,
        currency: 'usd',
        description: charge_details.to_json,
        source: stripe_token,
      })
      return true
    rescue Stripe::CardError => e
      error_message = e.error.message
      Rails.logger.error "Status is: #{e.http_status}"
      Rails.logger.error "Type is: #{e.error.type}"
      Rails.logger.error "Charge ID is: #{e.error.charge}"
      # The following fields are optional
      Rails.logger.error "Code is: #{e.error.code}" if e.error.code
      Rails.logger.error "Decline code is: #{e.error.decline_code}" if e.error.decline_code
      Rails.logger.error "Param is: #{e.error.param}" if e.error.param
      Rails.logger.error "Message is: #{error_message}" if error_message
      @stripe_error_message = error_message
      return false
    rescue Stripe::RateLimitError => e
      Rails.logger.error "Stripe RateLimitError: #{e}"
      @stripe_error_message = "Payment processing error"
      return false
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error "Stripe InvalidRequestError: #{e}"
      @stripe_error_message = "Payment processing error"
      return false
    rescue Stripe::AuthenticationError => e
      Rails.logger.error "Stripe AuthenticationError: #{e}"
      @stripe_error_message = "Payment processing error"
      return false
    rescue Stripe::APIConnectionError => e
      Rails.logger.error "Stripe API Connection Error: #{e}"
      @stripe_error_message = "Payment processing error"
      return false
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe Error: #{e}"
      @stripe_error_message = "Payment processing error"
      return false
    rescue => e
      @stripe_error_message = "System processing error"
      return false
    end
  end

end
