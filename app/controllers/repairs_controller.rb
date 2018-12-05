class RepairsController < ApplicationController
  include SortsModels
  include FiltersModels

  sorts :repairs, :created_at, :code, :customer_id, :artifact_id, :state, :cost

  before_action :authenticate_user!, except: [:query]
  before_action :set_repair, only: [:show, :finish, :edit, :update]

  # GET /repairs
  # GET /repairs
  def index
    unless state_filter == ""
      @repairs = Repair.where(state: state_filter).order(repairs_sort_params)
    else
      @repairs = Repair.order(repairs_sort_params)
    end

    @repairs = @repairs.page(params[:page])
  end

  # GET /repairs/:id
  # GET /repairs/:id.json
  def show
    @revisions = @repair.revisions.order(:created_at).page(params[:page])
    @artifact = @repair.artifact
  end

  # GET /repairs/:code/created
  # GET /repairs/:code/created.json
  def created
    @repair = Repair.find_by_code(params[:code])
    @artifact = @repair.artifact
  end

  # GET /repairs?code=:code
  def query
    @repair = Repair.find_by_code(params[:code].upcase)
    @artifact = @repair.artifact

    unless @repair.nil?
      @revisions = @repair.revisions.order(:created_at).page(params[:page])
      render 'show'
    else
      render 'not_found', locals: { code: params[:code] }
    end
  end

  # POST /:repair_id/finish
  # POST /:repair_id/finish.json
  def finish
    return if @repair.state == "FINALIZADO"

    @repair.state = "FINALIZADO"
    @repair.save!
  end

  def edit
    @selected_customer = @repair.customer
    @selected_customer = { label: "#{@selected_customer.name}, #{@selected_customer.surname}", value: @selected_customer.id }.to_json

    @selected_artifact = @repair.artifact
    @selected_artifact = { label: "#{@selected_artifact.name}, #{@selected_artifact.model}", value: @selected_artifact.id }.to_json

    @customers = Customer.all.collect { |customer| { label: "#{customer.name}, #{customer.surname}", value: customer.id } }.to_json
    @artifacts = Artifact.all.collect { |artifact| { label: "#{artifact.name}, #{artifact.model}", value: artifact.id } }.to_json
  end

  def update
    respond_to do |format|
      if @repair.update(repair_params)
        format.html { redirect_to artifact_repairs_path(params[:artifact_id]) }
        format.json { render json: @repair, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /repairs/new
  def new
    @repair = Repair.new

    if params[:customer_id]
      @selected_customer = Customer.find(params[:customer_id])
      @selected_customer = { label: "#{@selected_customer.name}, #{@selected_customer.surname}", value: @selected_customer.id }.to_json
    end

    if params[:artifact_id]
      @selected_artifact = Artifact.find(params[:artifact_id])
      @selected_artifact = { label: "#{@selected_artifact.name}, #{@selected_artifact.model}", value: @selected_artifact.id }.to_json
    end

    @customers = Customer.all.collect { |customer| { label: "#{customer.name}, #{customer.surname}", value: customer.id } }.to_json
    @artifacts = Artifact.all.collect { |artifact| { label: "#{artifact.name}, #{artifact.model}", value: artifact.id } }.to_json
  end

  # POST /repairs
  # POST /repairs.json
  def create
    @repair = Repair.new(repair_params)

    respond_to do |format|
      if @repair.save
        format.html { render 'created' }
        format.json { render json: @repair, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end
private
  def set_repair
    @repair = Repair.find(params[:id])
  end

  def repair_params
    params.require(:repair).permit(:customer_id, :artifact_id, :estimated_days)
  end

  def state_filter
    value = params[:state_filter] || ""
    value.upcase
  end
end
