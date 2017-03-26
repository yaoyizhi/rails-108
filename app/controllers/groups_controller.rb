class GroupsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :find_group_check_permission, only: [:edit, :update, :destroy]
    def index
        @groups = Group.all
    end

    def new
        @group = Group.new
    end

    def show
        @group = Group.find(params[:id])
        @posts = @group.posts.recent.paginate(page: params[:page], per_page: 5)
    end

    def create
        @group = Group.new(group_params)
        @group.user = current_user
        if @group.save
            current_user.join!(@group)
            redirect_to groups_path

        else
            render :new
    end
  end

    def edit; end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
            redirect_to groups_path
            flash[:notice] = 'Update Success'
        else
            render :edit
      end
  end

    def destroy
        @group = Group.find(params[:id])
        @group.destroy
        redirect_to groups_path
    end

    def join
        @group = Group.find(params[:id])
        if !current_user.is_member_of?(@group)
            current_user.join!(@group)
            flash[:notice] = '加入本讨论版成功'
        else
            flash[:alert] = '你已加入本讨论版'
        end
        redirect_to group_path
    end

    def quit
        @group = Group.find(params[:id])
        if current_user.is_member_of?(@group)
            current_user.quit!(@group)
            flash[:notice] = '你已退出讨论版'
        else
            flash[:alert] = '你已退出本讨论本，怎么再退出'
        end
        redirect_to group_path
    end

    private

    def group_params
        params.require(:group).permit(:title, :description)
    end

    def find_group_check_permission
        @group = Group.find(params[:id])
        if current_user != @group.user
            redirect_to root_path
            flash[:alert] = 'You have no permission'
        end
    end
end
