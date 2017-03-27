class PostsController < ApplicationController
    def new
        @group = Group.find(params[:group_id])
        @post = Post.new
    end

    def create
        @group = Group.find(params[:group_id])
        @post = Post.new(post_params)
        @post.group = @group
        @post.user = current_user
        if @post.save
            redirect_to group_path(@group)
        else
            render :new
        end
    end

    def edit
        @group = Group.find(params[:group_id])
        @post = Post.find(params[:id])
        @post.group = @group
    end

    def update
        @group = Group.find(params[:group_id])
        @post = Post.find(params[:id])
        @post.group = @group
        if  @post.update(post_params)
            @post.user = current_user
            redirect_to group_path(@group)
            flash[:notice] = 'Update Success'
        else
            render :edit
        end
        def destroy
            @group = Group.find(params[:group_id])
            @post = Post.find(params[:id])
            @post.destroy
            redirect_to group_path(@group)
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end
end
