module ShipmentsHelper
  def calculate_progress(delivery_status)
    case delivery_status.to_sym
    when :pending
      10
    when :approved
      33
    when :in_transits
      66
    when :delivered
      100
    else
      0
    end
  end
end
