class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum :role, [:admin, :customer, :delivery_partner]    

  has_many :customer_shipments, class_name: 'Shipment', foreign_key: :customer_id
  has_many :delivery_partner_shipments, class_name: 'Shipment', foreign_key: :delivery_partner_id
  
  def active_for_authentication?
    super && self.is_active?
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  def self.search(query)
    where("email LIKE ?", "%#{query}%")
  end
end
