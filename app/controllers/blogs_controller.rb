class BlogsController < ApplicationController
  before_action :load_project, only: [:index,:show,:edit,:new,:create,:update,:destroy]
  def index
    @blog = @project.blogs.order("created_at DESC")
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = @project.blogs.build blog_params
    @blog.user = current_user

    if @blog.save
      track_activity current_user, @project, @blog
      redirect_to project_blogs_path(@project)
    else
      flash[:error] = 'Name must be 5 character minimum'
      redirect_to new_project_blog_path(@project)
    end
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update(blog_params)
      redirect_to project_blogs_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to project_blogs_path(@project)
  end


  def load_project
    @project = Project.find params[:project_id]
  end

private
  def blog_params
    params.require(:blog).permit(:status,:title,:content)
  end
end
