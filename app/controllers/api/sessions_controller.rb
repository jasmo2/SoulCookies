module Api
  class SessionsController < BaseController

    def create
      if fb_params['uid'].nil?
        puts "Into create_customer"
        create_customer
      else
        puts "Into create_fb"
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
        customers_user.get_or_create_token
        render json: { customer_user: customers_user }
      else
        render json: {error: "Credendiales invalidas"}, status:  :forbidden
      end
    end

    def destroy
      session[:user_customer_id] = nil
      redirect_to root_url, :notice => "Logged out!"
    end

    private


    def fb_params
      params[:customers_user].permit("first_name", "last_name","uid","email")
    end
    def manual_params
      params[:customers_user].permit(:email, :password)
    end
  end
end
