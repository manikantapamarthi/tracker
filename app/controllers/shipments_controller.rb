class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
  end 
end
