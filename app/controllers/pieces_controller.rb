class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy]

  # GET /pieces
  # GET /pieces.json
  def index
    @artifact = Artifact.find(params[:artifact_id])
    @pieces = @artifact.pieces.order(:name).page(params[:page])
  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show
  end

  # GET /pieces/new
  def new
    @artifact = Artifact.find(params[:artifact_id])
    @piece = Piece.new
    @piece.artifact = @artifact
  end

  # GET /pieces/1/edit
  def edit
    @artifact = Artifact.find(params[:artifact_id])
  end

  # POST /pieces
  # POST /pieces.json
  def create
    @piece = Piece.new(piece_params)

    respond_to do |format|
      if @piece.save
        format.html { redirect_to (artifact_pieces_path(artifact_id: params[:artifact_id])), notice: 'Piece was successfully created.' }
        format.json { render :show, status: :created, location: @piece }
      else
        format.html { render :new }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/1
  # PATCH/PUT /pieces/1.json
  def update
    respond_to do |format|
      if @piece.update(piece_params)
        format.html { redirect_to artifact_pieces_path(params[:artifact_id]), notice: 'Piece was successfully updated.' }
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
    redirect_to artifact_pieces_path(params[:artifact_id]), notice: (t 'customers.flash.deleted'), status: 303
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_piece
      @piece = Piece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def piece_params
      params.require(:piece).permit(:name, :description, :artifact_id)
    end
end
