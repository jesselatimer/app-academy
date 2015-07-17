module TracksHelper
  def delete_track
    button_to "Delete Track",
    track_url(@track),
    method: :delete,
    data: { confirm: "Are you sure you want to delete #{@track.title}?" }
  end
end
