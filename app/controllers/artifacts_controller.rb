class ArtifactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_artifact, only: [:show, :edit, :update, :destroy]

  # GET /artifacts
  def index
    @artifacts = Artifact.order(:name, :model).page(params[:page])
  end

  # GET /artifacts/:id
  def show
  end

  # GET /artifacts/new
  def new
    @artifact = Artifact.new
  end

  # GET /artifacts/:id/edit
  def edit
  end

  # POST /artifacts
  def create
    @artifact = Artifact.new(artifact_params)

    if @customer.save
      if params[:go_to_repair].present?
        redirect_to new_repair_path(artifact_id: @artifact)
      else
        redirect_to @artifact, notice: (t 'artifacts.flash.created')
      end
    else
      render :new
    end
  end

  # PATCH/PUT /artifacts/:id
  def update
    if @artifact.update(artifact_params)
      redirect_to @artifact, notice: (t 'artifacts.flash.updated')
    else
      render :edit
    end
  end

  # DELETE /artifacts/:id
  def destroy
    @artifact.destroy
    redirect_to artifacts_url, notice: (t 'artifacts.flash.deleted'), status: 303
  end
private
  def set_artifact
    @artifact = Artifact.find(params[:id])
  end

  def artifact_params
    params.require(:artifact).permit(:name, :model, :description)
  end
end
