module BandsHelper
  def delete_band
    button_to "Delete Band",
    band_url(@band),
    method: :delete,
    data: { confirm: "Are you sure you want to delete #{@band.name}?" }
  end
end
