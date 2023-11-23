class Shipment < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :delivery_partner, class_name: 'User', optional: true
end
