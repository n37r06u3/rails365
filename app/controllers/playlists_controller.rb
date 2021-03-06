class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show]
  authorize_resource

  def index
    @playlists = Rails.cache.fetch 'playlist_all' do
      Playlist.where(is_original: true).order(weight: :desc).to_a
    end
    @title = "播放列表"
  end

  def show
    @title = @playlist.name
  end

  private

  def set_playlist
    @playlist = Playlist.fetch_by_slug!(params[:id])
    @movies = @playlist.fetch_movies
  end
end
