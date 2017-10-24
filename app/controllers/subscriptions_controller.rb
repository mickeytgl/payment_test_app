class SubscriptionsController < ApplicationController 
	before_action :authenticate_user!, except: [:new]
	before_action :redirect_to_signup, only: [:new]

	def show
	end

	def new 
	end

	def destroy
	end

	def create
		customer =	if current_user.stripe_id?
					Stripe::Customer.retrieve(current_user.stripe_id)
					else
					Stripe::Customer.create(email: current_user.email)
					end
		
		subscription = customer.subscriptions.create( 
			source: params[:stripeToken],
			plan: "yearly"
		)

		current_user.update(
			stripe_id: customer.id,
			stripe_subscription_id: subscription.id,
			card_last4: params[:card_last4],
			card_type: params[:card_brand],
			card_exp_month: params[:card_exp_month],
			card_exp_year: params[:card_exp_year]
		)
		
		#redirect_to root_path	
	end


	private 

		def redirect_to_signup
			if !user_signed_in?
				session["user_return_to"] = new_subscription_path
				redirect_to new_user_registration_path 
			end
		end
end