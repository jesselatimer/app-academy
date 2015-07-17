module AlbumsHelper
  def delete_album
    button_to "Delete Album",
    album_url(@album),
    method: :delete,
    data: { confirm: "Are you sure you want to delete #{@album.title}?" }
  end
end
