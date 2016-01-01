class Api::V1::UrlsController < Api::V1::ApiController

  def index
    raise_not_found if params[:url].nil?

    @url = ProductParser.new(params[:url])
    @url.parse!
  end
end