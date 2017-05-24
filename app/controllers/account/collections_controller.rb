class Account::CollectionsController < ApplicationController

  def index
    @user = current_user
    @collections = Collection.where(:user => @user).newest_first.paginate(:page => params[:page], per_page: 7)
  end


end
