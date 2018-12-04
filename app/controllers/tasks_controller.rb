class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_artifact, except: [:destroy]

  # GET /artifacts/:artifact_id/tasks
  # GET /artifacts/:artifact_id/tasks.json
  def index
    @tasks = @artifact.tasks.order(:name).page(params[:page])
  end

  # GET /tasks/:id
  def show
    @artifact = @task.artifact
  end

  # GET /artifacts/:artifact_id/tasks/new
  def new
    @task = Task.new(artifact: @artifact)
  end

  # GET /tasks/:id/edit
  def edit
  end

  # POST /artifacts/:artifact_id/tasks
  # POST /artifacts/:artifact_id/tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to (artifact_tasks_path(artifact_id: @task.artifact_id)), notice: (t 'tasks.flash.created')}
        format.json { render json: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/:id
  # PATCH/PUT /tasks/:id.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to artifact_tasks_path(artifact_id: @task.artifact_id), notice: (t 'tasks.flash.updated') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/:id
  # DELETE /tasks/:id.json
  def destroy
    @task.destroy

    redirect_to artifact_tasks_path(@task.artifact_id), notice: (t 'tasks.flash.deleted'), status: 303
  end
private
  def set_artifact
    @artifact = Artifact.find(params[:artifact_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :cost, :artifact_id)
  end
end
