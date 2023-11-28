require 'rails_helper'

RSpec.describe ShipmentsController, type: :controller  do
  before do
    
    sign_in user 
  end
  
  describe 'GET #new' do
    let(:user) { FactoryBot.create(:user, :customer) }
    subject { get :new } 
    it 'assigns a new shipment' do
      expect(subject).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user, :customer) }
    let(:shipment_params) { { source_location: 'Location A', target_location: 'Location B', item_description: 'Test item' } }

    it "create a new shipment" do
      expect {
        post :create, params: { shipment: shipment_params }
        }.to change(Shipment, :count).by(1)
    end

    it 'assigns the correct customer to the shipment' do
      post :create, params: { shipment: shipment_params }
      expect(Shipment.last.customer_id).to eq(user.id)
    end

    it 'sends a notification email to the delivery partner' do
      expect {
        post :create, params: { shipment: shipment_params }
      }.to have_enqueued_mail(DeliveryPartnerNotificationMailer)
    end

    it 'redirects to the created shipment' do
      post :create, params: { shipment: shipment_params }
      expect(response).to redirect_to(shipment_path(Shipment.last))
      expect(flash[:notice]).to eq('Shipment created successfully')
    end
  end
end