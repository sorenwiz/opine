class AddImageFilesToPoll < ActiveRecord::Migration
  def change
    add_attachment :polls, :image
    add_attachment :polls, :background_image
  end
end
