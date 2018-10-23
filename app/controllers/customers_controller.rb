class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.order(:surname).page(params[:page])
  end

  # GET /customers/:id
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/:id/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: (t 'customers.flash.created')
    else
      render :new
    end
  end

  # PATCH/PUT /customers/:id
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: (t 'customers.flash.updated')
    else
      render :edit
    end
  end

  # DELETE /customers/:id
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: (t 'customers.flash.deleted')
  end
private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :surname, :phone, :email, :notes)
  end
end
