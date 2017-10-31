class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_signup, only: [:new]

  def show
  end

  def new
  end

  def create
    user = current_user.stripe_customer
    user.card_token = params[:stripeToken]
    user.subscribe(plan = 'monthly')
    #update_card

    redirect_to root_path
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)

    redirect_to root_path, notice: "Your subscription has been canceled."
  end

  private

    def redirect_to_signup
      if !user_signed_in?
        session["user_return_to"] = new_subscription_path
        redirect_to new_user_registration_path
      end
    end
end