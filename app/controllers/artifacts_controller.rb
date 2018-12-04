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
  # POST /artifacts.json
  def create
    @artifact = Artifact.new(artifact_params)

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to @artifact, notice: (t 'artifacts.flash.created') }
        format.json { render json: @artifact, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artifacts/:id
  # PATCH/PUT /artifacts/:id.json
  def update
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to @artifact, notice: (t 'artifacts.flash.updated') }
        format.json { render json: @artifact, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
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
