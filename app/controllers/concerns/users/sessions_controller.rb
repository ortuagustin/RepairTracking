class Users::SessionsController < Devise::SessionsController
  # GET /users/login
  def new
    redirect_to root_path
  end

  # POST /users/login
  def create
    super
  end

  # DELETE /users/logout
  def destroy
    super
  end
end
