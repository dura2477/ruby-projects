class UsersController < ApplicationController
  before_filter :authenticate_user!

  def info
  	@subscription = current_user.subscription


  end

  def charge
  	token = params["stripetoken"]

  	customer = Stripe::Customer.create(
        source: token,
        plan: 'mysubscriptionlevel1',
        email: current_user.email
  		)

  	current_user.subscription.stripe_user_id =
  	customer.id
  	current_user.subscription.active = true
  	current_user.subscription.save

  	redirect_to users_info_path
end
end
