class Admin::CategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :is_website_admin?

  layout 'admin'


  def index
    @categorys = Category.all.newest_first
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.sort = Category.newest_first.first.sort + 1
    if @category.save!
      redirect_to admin_categories_path, notice: "Create new category successfully"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Updated successfully"
    else
      render :edit
    end

  end

  def publish
    @category = Category.find(params[:id])
    @category.publish!
    redirect_to :back
  end

  def hide
    @category = Category.find(params[:id])
    @category.hide!
    redirect_to :back
  end

  def up
    @category = Category.find(params[:id])
    @categoryX = Category.find_by(sort: @category.sort - 1)
    @category.sort -= 1

    if @category.sort > 0
      @category.save
    end

    if @categoryX.present?
      @categoryX.sort += 1
      @categoryX.save
    end

    redirect_to :back

  end

  def down
    @category = Category.find(params[:id])
    @categoryX = Category.find_by(sort: @category.sort + 1)
    @category.sort += 1
    @category.save

    if @categoryX.present?
      @categoryX.sort -= 1
      @categoryX.save
    end

    redirect_to :back

  end


private

  def category_params
    params.require(:category).permit(:name, :icon, :is_hidden)
  end


end
