class CardsController < ApplicationController
  before_action :authenticate_user!
  #before_action :current_user_subscribed?

  def update
    user = current_user
    user.card_token = params[:stripeToken]
    user.update_card(params[:stripeToken])

    user.update_card_on_file(params)

    redirect_to edit_user_registration_path, notice: "Successfully updated your card"
  end
end