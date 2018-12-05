class CustomersController < ApplicationController
  include FiltersModels
  include SortsModels

  sorts :customers, :name, :surname, :phone, :email, :id

  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.order(customers_sort_params).page(params[:page])
  end

  # GET /customers/:id
  def show
    @repairs = @customer.repairs.order(:created_at).page(params[:page])
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/:id/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: (t 'customers.flash.created') }
        format.json { render json: @customer, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/:id
  # PATCH/PUT /customers/:id.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: (t 'customers.flash.updated') }
        format.json { render json: @customer, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/:id
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: (t 'customers.flash.deleted'), status: 303
  end
private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :surname, :phone, :email, :notes)
  end
end
