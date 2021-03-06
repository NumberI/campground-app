class CampgroundsController < ApplicationController
  before_action :set_campground, only: %i[ show update destroy ]

  # GET /campgrounds
  def index
    @campgrounds = Queries::CampgroundCollectionQuery.call(filtered_index)

    render json: @campgrounds
  end

  # GET /campgrounds/1
  def show
    render json: @campground
  end

  # POST /campgrounds
  def create
    @campground = Campground.new(campground_params)

    if @campground.save
      render json: @campground, status: :created, location: @campground
    else
      render json: @campground.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campgrounds/1
  def update
    if @campground.update(campground_params)
      render json: @campground
    else
      render json: @campground.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campgrounds/1
  def destroy
    @campground.destroy
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_campground
      @campground = Campground.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campground_params
      params.require(:campground).permit(:name)
    end

    def filtered_index
      params.permit(:date_range, :sorting)
    end
end
