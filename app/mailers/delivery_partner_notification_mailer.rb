class DeliveryPartnerNotificationMailer < ApplicationMailer
  default from: "manikanta@example.com"

  def delivery_assigned_notification(shipment)
    @shipment = shipment
    @delivery_partner = shipment.delivery_partner
    mail(to: @delivery_partner.email, subject: "Shipment assigned notification")
  end
end
