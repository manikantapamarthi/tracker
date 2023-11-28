class Shipment < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :delivery_partner, class_name: 'User', optional: true
  enum :status, [:pending, :approved, :in_transits, :delivered]
  validates :source_location, :target_location, :item_description, presence: true

  after_create :set_order_id

  def self.search(query)
    where("order_id LIKE ?", "%#{query}%")
  end

  private
  def set_order_id
    order_id = SecureRandom.random_number(10000000) 
    self.update_column(:order_id, order_id)
  end
end
