class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :phone_number, presence: true, numericality: true, length: {minimum:10, maximum:12}, uniqueness: true     
         
  enum :role, [:admin, :customer, :delivery_partner]    

  has_many :customer_shipments, class_name: 'Shipment', foreign_key: :customer_id
  has_many :delivery_partner_shipments, class_name: 'Shipment', foreign_key: :delivery_partner_id
  
  has_one_attached :avatar

  has_many_attached :documents

  scope :active_delivery_partner, -> { where(role: "delivery_partner", is_active: true)}

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
