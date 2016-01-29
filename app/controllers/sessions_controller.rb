class SessionsController < ApplicationController
  #
  def new
  end

  def create_f
    @customers_user = CustomersUser.where(uid: fb_params['id'])
    if @customers_user.empty?
      @customers_user = CustomersUser.new(fb_params)
      session[:user_customer_id] = @customers_user.id
      render "/customers_users/new"
    end
    session[:user_customer_id] = @customers_user.id
    render :nothing, status: 201
  end


  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_customer_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_customer_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  private
  def fb_params
    params.permit("first_name", "last_name","id","email")
  end
end
