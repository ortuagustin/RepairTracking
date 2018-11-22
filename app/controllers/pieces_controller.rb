class PiecesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_piece, only: [:show, :edit, :update, :destroy]
  before_action :set_artifact, only: [:index, :new, :edit, :destroy]

  # GET /pieces
  # GET /pieces.json
  def index
    @pieces = @artifact.pieces.order(:name).page(params[:page])
  end

  # GET /pieces/new
  def new
    @piece = Piece.new
    @piece.artifact = @artifact
  end

  # GET /pieces/:id/edit
  def edit
  end

  # POST /pieces
  # POST /pieces.json
  def create
    @piece = Piece.new(piece_params)
    @artifact = @piece.artifact || Artifact.find(artifact_id)

    respond_to do |format|
      if @piece.save
        format.html { redirect_to (artifact_pieces_path(artifact_id: artifact_id)), notice: (t 'pieces.flash.created')}
        format.json { render json: @piece }
      else
        format.html { render :new }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/:id
  # PATCH/PUT /pieces/:id.json
  def update
    respond_to do |format|
      if @piece.update(piece_params)
        format.html { redirect_to artifact_pieces_path(artifact_id), notice: (t 'pieces.flash.updated') }
        format.json { render :show, status: :ok, location: @piece }
      else
        format.html { render :edit }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pieces/1
  # DELETE /pieces/1.json
  def destroy
    @piece.destroy

    redirect_to artifact_pieces_path(artifact_id), notice: (t 'pieces.flash.deleted'), status: 303
  end

private
  def set_piece
    @piece = Piece.find(params[:id])
  end

  def set_artifact
    @artifact = Artifact.find(artifact_id)
  end

  def artifact_id
    params[:artifact_id]
  end

  def piece_params
    params.require(:piece).permit(:name, :description, :artifact_id)
  end
end
