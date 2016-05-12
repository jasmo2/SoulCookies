class PasswordResetsController < ApplicationController
  def new
  end

  def create
    customer_user = CustomersUser.where(email_params).first
    customer_user.send_password_reset if customer_user
    redirect_to root_url, :notice => "Se ha enviado un correo con instrucciones."
  end

  def edit
    @customer_user = CustomersUser.find_by_password_reset_token!(params[:id])
  end

  def update
    @customer_user = CustomersUser.find_by_password_reset_token!(params[:id])
    if @customer_user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @customer_user.update_attributes(customer_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
  private
  def email_params
    params.permit(:email)
  end
  def customer_params
    params.require(:customers_user).permit(:password,:password_confirmation)
  end
end
