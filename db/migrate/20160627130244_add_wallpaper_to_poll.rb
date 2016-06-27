class AddWallpaperToPoll < ActiveRecord::Migration
  def change
    add_attachment :polls, :wallpaper
  end
end
