class User < ApplicationRecord
  include Pay::Billable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :name, presence: true
  has_many :subscriptions

  def first_name
    name.split(' ').first
  end

  def subscribed?
  	processor_id? 
  end
end
