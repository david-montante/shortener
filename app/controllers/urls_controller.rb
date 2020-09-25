class UrlsController < ApplicationController
  def index
    @urls = Url.all
    render json: @urls
  end

  def show
    @url = Url.find_by(id: decode_url(show_params[:id]))
    render json: {error: "Short url does not exits"} and return if @url.blank?
    redirect_to @url.original_url
  end

  def create
    original_url = create_params[:original_url]
    @url = Url.find_by(original_url: original_url)
    @url = Url.create(original_url: original_url) if @url.blank?

    render json: {
      id: @url.id,
      original_url: @url.original_url,
      short_url: @url.short_url
    }
  end

  private

  def create_params
    params.require(:urls).permit(:original_url)
  end

  def show_params
    params.permit(:id)
  end

  def decode_url(s)
    i = 0
    base = ALPHABET.length
    s.each_char { |c| i = i * base + ALPHABET.index(c) }
    i
  end
end
