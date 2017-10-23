class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :name, presence: true

  def first_name
    name.split(' ').first
  end

  def subscribed?
  	stripe_subscription_id? 
  end
end
