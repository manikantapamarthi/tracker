class ShipmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shipment, only: [:show, :edit, :update, :destroy, :get_status, :track]
  before_action :set_shipments, only: [:index]

  def index
    @pagy, @shipments = pagy(@shipments)
  end

  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params.merge(customer_id: current_user.id))
    authorize @shipment
    respond_to do |format|
      if @shipment.save
        DeliveryPartnerNotificationMailer.delivery_assigned_notification(@shipment).deliver_later
        format.html { redirect_to shipment_path(@shipment), notice: "Shipment created successfully"}
      else
        format.html { render :new, alert: @shipment.errors.full_messages.join(', ') } 
      end
    end
  end

  def show
  end
  
  def edit
    authorize @shipment
  end

  def get_status
  end

  def update
    respond_to do |format|
      if @shipment.update(shipment_params)
        format.html { redirect_to @shipment, notice: "Shipment updated successfully" }
        format.turbo_stream do 
          render turbo_stream: turbo_stream.replace(
            "status_#{@shipment.id}",
            partial: 'shipments/status',
            locals: { shipment: @shipment }
          )
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def track
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.after(
          "row_shipment_#{@shipment.id}",
          partial: 'shipments/tracking_details',
          locals: { shipment: @shipment}
        ) 
      end
    end
  end
  

  def destroy
  end

  private
  def shipment_params
    params.require(:shipment).permit(:source_location, :target_location, :item_description, :delivery_partner_id,:status)
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
    redirect_to root_path, alert: 'Shipment not found' unless @shipment
  end

  def set_shipments
    @shipments = determine_shipments
    @shipments = @shipments.search(params[:query]) if params[:query].present?
  end

  def determine_shipments
    case current_user.role
    when 'customer'
      current_user.customer_shipments
    when 'delivery_partner'
      current_user.delivery_partner_shipments
    else
      Shipment.all
    end
  end
end
