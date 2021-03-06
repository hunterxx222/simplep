class TasksController < ApplicationController
  before_action :load_project, only: [:new, :edit, :create, :show, :completed, :destroy]
  before_action :load_task, only: [:edit,:show,:completed,:update,:destroy ]
  def new
    @task = Task.new
  end

  def sort
    params[:postition].each do |key, value|
      Task.find(value[:id]).update_attribute(:position, value[:position])
    end

    render :nothing => true
  end

  def edit
  end

  def index
    if params[:q]
      @tasks = @search.result
    elsif current_user
      @tasks = current_user.tasks.order('position')
    end
  end

  def create

    @task = @project.tasks.build task_params
    @task.owner = current_user

    if @task.save
      track_activity current_user, @project, @task
      @project.reload
      respond_to do |format|
        format.html { redirect_to @project }
        format.json #{ render json: @project }
        #NOTE: adding format.js shows an uneccessary modal
        format.js
      end
    else
      flash[:error] = "#{ @project.errors.full_messages.to_sentence }"
      redirect_to teams_path
    end
  end

  def user_team
    if current_team
      @users = current_team.team_member
    end

    respond_to do |format|
      format.json {render json: @users}
    end

  end
  def show

    respond_to do |format|

      format.html {redirect_to @project}
      if params[:redirect] == "true"
        flash[:task] = @task.id
      else
        format.js
      end
    end
  end

  def completed
    if params[:completed] == "true"
      @task.completed_at = Time.zone.now
      @task.save
      track_activity current_user, @task, nil, 'completed'
    elsif params[:completed] == "false"
      @task.completed_at = nil
      Activity.where(subject: @task, action: 'completed').each {|a| a.destroy!}
      @task.save
    end

    respond_to do |format|
      format.js
#      format.html {redirect_to project_path(@project)}
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
#      format.html {redirect_to project_path(@project)}
      format.js
    end
  end


  def deadline
    load_project
    @task = Task.find params[:id]
    if params[:due_date]
      @task.due_date = params[:due_date]
      if @task.save
        flash[:success] = "Change deadline successfully"
      else
        flash[:error] = "Change deadline failed"
      end
    end

    respond_to do |format|
      #format.html {redirect_to project_path(@project)}
      format.js
    end
  end

  def update
      respond_to do |format|
        if @task.update(task_params)
          format.html {redirect_back fallback_location: project_tasks_path(@project),:notice => 'Task was successfully updated'}
          format.json {respond_with_bip(@task)}
        else
          format.html {render 'edit'}
          format.json {respond_with_bip(@task)}
        end
      end
  end

  def destroy
    @task.destroy
    redirect_back fallback_location: project_path(@project)
  end
  private

  def load_task
    @task = Task.find params[:id]
  end

  def load_project
    @project = Project.find params[:project_id]
  end
end
