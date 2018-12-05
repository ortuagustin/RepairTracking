class RevisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_repair, only: [:index, :new]
  before_action :set_revision, only: [:destroy]

  # GET /repairs/:repair_id/revisions
  # GET /repairs/:repair_id/revisions.json
  def index
    @revisions = @repair.revisions.order(:created_at).page(params[:page])
  end

  # GET /repairs/:repair_id/revisions/new
  def new
    @revision = Revision.new(repair: @repair)
  end

  # POST /:repair_id/revisions
  # POST /:repair_id/revisions.json
  def create
    @revision = Revision.new(revision_params)

    respond_to do |format|
      if @revision.save
        format.html { redirect_to (repair_revisions_path(repair_id: @revision.repair_id)), notice: (t 'revisions.flash.created')}
        format.json { render json: @revision }
      else
        format.html { render :new }
        format.json { render json: @revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revisions/:id
  # DELETE /revisions/:id.json
  def destroy
    @revision.destroy

    redirect_to repair_revisions_path(repair_id: @revision.repair_id), notice: (t 'revisions.flash.deleted'), status: 303
  end
private
  def set_repair
    @repair = Repair.find(params[:repair_id])
  end

  def set_revision
    @revision = Revision.find(params[:id])
  end

  def revision_params
    params.require(:revision).permit(:notes, :repair_id)
  end
end
