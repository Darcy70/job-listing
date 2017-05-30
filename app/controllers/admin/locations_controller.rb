class Admin::LocationsController < ApplicationController

  before_action :authenticate_user!
  before_action :is_website_admin?

  layout 'admin'


  def index
    @locations = Location.all.newest_first
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.sort = Location.newest_first.first.sort + 1
    if @location.save!
      redirect_to admin_categories_path, notice: "Create new location successfully"
    else
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)

    if @location.save
      redirect_to admin_categories_path, notice: "Updated successfully"
    else
      render :edit
    end

  end

  def publish
    @location = Location.find(params[:id])
    @location.publish!
    redirect_to :back
  end

  def hide
    @location = Location.find(params[:id])
    @location.hide!
    redirect_to :back
  end

  def up
    @location = Location.find(params[:id])
    @locationX = Location.find_by(sort: @location.sort - 1)
    @location.sort -= 1

    if @location.sort > 0
      @location.save
    end

    if @locationX.present?
      @locationX.sort += 1
      @locationX.save
    end

    redirect_to :back

  end

  def down
    @location = Location.find(params[:id])
    @locationX = Location.find_by(sort: @location.sort + 1)
    @location.sort += 1
    @location.save

    if @locationX.present?
      @locationX.sort -= 1
      @locationX.save
    end

    redirect_to :back

  end


  private

  def location_params
    params.require(:location).permit(:name, :is_hidden)
  end


end
