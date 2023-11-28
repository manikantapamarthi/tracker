class ShipmentPolicy < ApplicationPolicy
  
  def create?
    user.customer?
  end

  def new?
    create?
  end

  def edit?
    user.customer?
  end

  def update?
    edit?
  end
end