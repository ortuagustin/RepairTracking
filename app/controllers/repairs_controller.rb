class RepairsController < ApplicationController
  # GET /repairs/1
  # GET /repairs/1.json
  def show
    @repair = Repair.find(params[:id])
  end

  # GET /repairs/new
  def new
    @repair = Repair.new
    @customers = Customer.all.collect { |customer| [ "#{customer.name}, #{customer.surname}", customer.id ] }
    @artifacts = Artifact.all.collect { |artifact| [ artifact.name, artifact.id ] }
  end

  # POST /repairs
  # POST /repairs.json
  def create
    @repair = Repair.new(repair_params)

    respond_to do |format|
      if @repair.save
        format.html { redirect_to @repair, notice: (t 'repairs.flash.created') }
        format.json { render :show, status: :created, location: @repair }
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
