class SessionsController < ApplicationController
  #
  def new
    respond_to do |f|
      f.js{
        render 'new'
      }
    end
  end

  def create
    if fb_params['uid'].nil?
      create_customer
    else
      create_fb
    end
  end

  def create_fb
    @customers_user = CustomersUser.where(uid: fb_params['uid']).first
    if @customers_user.nil?
      @customers_user = CustomersUser.new(fb_params)
      session[:user_customer_id] = @customers_user.id
      render "/customers_users/create_fb"
    else
     session_accepted (@customers_user)
     render :nothing => true, status: :accepted, :content_type => 'text/html'
    end
  end


  def create_customer
    customers_user = CustomersUser.authenticate(manual_params)
    if customers_user
      session_accepted (customers_user)
      respond_to do |format|
        format.js {render js: 'window.location.reload();'}
      end

    else
       render js: " sweetAlert('Error','Credenciales invalidas', 'warning');", status:  :bad_request
    end
  end

  def destroy
    session[:user_customer_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private
  def session_accepted customers_user
    session[:user_customer_id] = customers_user.id
  end

  def fb_params
    params.permit("first_name", "last_name","uid","email")
    end
  def manual_params
    params.permit(:email, :password)
  end
end
