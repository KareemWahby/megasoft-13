class TasksController < ApplicationController
  ## 
  # passes the list of tasks that belongs to the project to the index view
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def index
    @tasks = Project.find(params[:project_id]).tasks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  ## 
  # Make a new instance of task and render new view that has the form
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end
  ## 
  # Find the task with the project_id and render edit view that has the form to edit the task
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def edit
    @task = Project.find(params[:project_id]).tasks.find(params[:id])
  end
  ## 
  # Use the :task parameter to create an instance of tasks related to current project
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def create
    @task = Project.find(params[:project_id]).tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  ## 
  # get the new parameters and update the database
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to project_tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  ## 
  # destroy the task with :id
  # * *Args* :
  # - 
  # * *Returns* :
  # - 
  #
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_path }
      format.json { head :no_content }
    end
  end
end
