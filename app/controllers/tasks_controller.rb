class TasksController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def index
      @search = Task.search(params[:q])
    if params[:q]
      @tasks = @search.result
    else
      if current_user
        @tasks = current_user.tasks
      end
    end

  end

  def create
    load_project
    @task = @project.tasks.build task_params
    @task.owner = current_user

    if @task.save
      track_activity current_user, @project, @task
      redirect_to project_path(@project)
    else
      flash[:error] = 'Name must be 5 character minimum'
      redirect_to new_project_task_path(@project)
    end

  end

  def show
    load_project
    @task = Task.find params[:id]

    respond_to do |format|
      format.html do
       redirect_to project_path(@project)
      end

      format.js
    end


  end

  def completed
    load_project
    @task = Task.find params[:id]
    if params[:completed] == "true"
      @task.completed_at = Time.now
      @task.save
      track_activity current_user, @task, nil, 'completed'
    elsif params[:completed] == "false"
      @task.completed_at = nil
      @task.save
    end

    respond_to do |format|
      format.js
      format.html {redirect_to project_path(@project)}
    end
  end

  def owner
    load_project
    @task = Task.find params[:id]
    if params[:owner_id]
      @owner = User.find params[:owner_id]
      @task.owner_id = params[:owner_id]
      @task.save
      track_activity current_user, @task, @owner, 'assign'
    end

    respond_to do |format|
      format.html {redirect_to project_path(@project)}
      format.js
    end
  end


  def deadline
    load_project
    @task = Task.find params[:id]
    if params[:due_date]
      @task.due_date = params[:due_date]
      @task.save
    end

    respond_to do |format|
      format.html {redirect_to project_path(@project)}
      format.js
    end
  end

  def update

  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy
    redirect_to project_path(@project)
  end
  private
  def task_params
    params.require(:task).permit(:name)
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
