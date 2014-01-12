class GroupsController < ApplicationController

  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      flash[:notice] = 'Group was successfully created.'
      redirect_to user_group_path(current_user, @group)
    else
      flash[:notice] = 'There was an error'
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = current_user.groups
  end

  private

    def group_params
      params.require(:group).permit(:title)
    end

end