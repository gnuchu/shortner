class Api::V1::UrlsController < ApplicationController
  before_action :set_url, only: [:show, :update, :destroy]

  #horrible hack
  BASE_URL = "http://localhost:3000/api/v1/urls/"

  # GET /urls
  def index
    @urls = Url.all

    render json: @urls
  end

  # GET /urls/1
  def show
    render json: @url
  end

  # POST /urls
  def create
    @url = Url.new(url_params)

    exists = Url.find_by target: @url.target

    if exists != nil
      location = BASE_URL + exists.id.to_s
      render json: exists, status: :found, location: location
    else
      if @url.save
        location = BASE_URL + @url.id.to_s
        render json: @url, status: :created, location: location
      else
        render json: @url.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /urls/1
  def update
    if @url.update(url_params)
      render json: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  # DELETE /urls/1
  def destroy
    @url.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def url_params
      params.require(:url).permit(:target)
    end
end
