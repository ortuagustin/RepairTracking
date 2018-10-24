class RepairsController < ApplicationController
  # GET /repairs/1
  # GET /repairs/1.json
  def show
    @repair = Repair.find_by_code(params[:id])
    @revisions = @repair.revisions.order(:created_at).page(params[:page])
    render 'show_code'
  end

  # GET /repairs?code=:code
  def query
    @repair = Repair.find_by_code(params[:code])

    unless @repair.nil?
      @revisions = @repair.revisions.order(:created_at).page(params[:page])
      render 'show'
    else
      render 'not_found', locals: { code: params[:code] }
    end
  end

  # GET /repairs/new
  def new
    @repair = Repair.new
    @customers = Customer.all.collect { |customer| { label: "#{customer.name}, #{customer.surname}", value: customer.id } }.to_json
    @artifacts = Artifact.all.collect { |artifact| { label: artifact.name, value: artifact.id } }.to_json
  end

  # POST /repairs
  # POST /repairs.json
  def create
    @repair = Repair.new(repair_params)

    respond_to do |format|
      if @repair.save
        format.html { render 'show_code' }
        format.json { render json: @repair, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end
private
  def repair_params
    params.require(:repair).permit(:customer_id, :artifact_id, :estimated_days)
  end
end
