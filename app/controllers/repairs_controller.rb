class RepairsController < ApplicationController
  # GET /repairs/1
  # GET /repairs/1.json
  def show
    @repair = Repair.find_by_code(params[:id])
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
        format.html { redirect_to @repair, notice: (t 'repairs.flash.created') }
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
