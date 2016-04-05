# == Schema Information
#
# Table name: shoppe_customers
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  company                :string
#  email                  :string
#  phone                  :string
#  mobile                 :string
#  created_at             :datetime
#  updated_at             :datetime
#  password_hash          :string
#  password_salt          :string
#  provider               :string
#  uid                    :string
#  name                   :string
#  oauth_token            :string
#  oauth_expires_at       :datetime
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#
module Api
  class CustomersUsersController < BaseController
    before_action :access_private, only: [:update, :destroy]

    def create
      @customers_user = CustomersUser.new(customers_user_params)
      begin @customers_user.save!
      render json: {"response": 201}, status: :created
      rescue ActiveRecord::RecordInvalid  => e
        render :json => {:error =>  Api::Exceptions::I18n_m.new(CustomersUser, @customers_user).i18n_attributes }, status: :bad_request
      rescue Exception => e
        render :json => {:error => "#{e}" }, status: :bad_request
      end

    end


    def update
      current_customer.attributes = customers_user_params
      begin current_customer.save!
        render json: {"customer_user": "actualizado exitosamente"}, status: :ok
      rescue ActiveRecord::RecordInvalid  => e
        render :json => {:error =>  Api::Exceptions::I18n_m.new(CustomersUser, current_customer).i18n_attributes }, status: :bad_request
      rescue Exception => e
        render :json => {:error => "#{e}" }, status: :bad_request
      end

    end

    def destroy
        begin Shoppe::Address.where(customer_id: current_customer.id).destroy_all
           current_customer.destroy
           render json: { notice: 'El usuario fué eleminado correctamente'},status: :ok
        rescue Exception => e
           render :json => {:error => "#{e}" }, status: :bad_request
        end
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def customers_user_params
      params[:customers_user].permit(:first_name, :last_name,:email,:phone,:uid,:password,:password_confirmation)
    end
  end
end
