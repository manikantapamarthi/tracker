require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:source_location) }
    it { should validate_presence_of(:target_location) }
    it { should validate_presence_of(:item_description) }
  end

  describe 'associations' do
    it { should belong_to(:customer).class_name('User') }
    it { should belong_to(:delivery_partner).class_name('User').optional }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:pending, :approved, :in_transits, :delivered]) }
  end
end
