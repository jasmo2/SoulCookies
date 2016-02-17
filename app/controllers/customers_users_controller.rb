# == Schema Information
#
# Table name: shoppe_customers
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  company          :string
#  email            :string
#  phone            :string
#  mobile           :string
#  created_at       :datetime
#  updated_at       :datetime
#  password_hash    :string
#  password_salt    :string
#  provider         :string
#  uid              :string
#  name             :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#

class CustomersUsersController < ApplicationController

  before_action :set_customers_user, only: [:show, :edit, :update, :destroy]
  before_filter :address_instance, only: :edit


  # GET /customers_users
  # GET /customers_users.json
  def index
    @customers_users = CustomersUser.all
  end

  # GET /customers_users/1
  # GET /customers_users/1.json
  def show
  end

  # GET /customers_users/new
  def new
    respond_to do |f|
      f.js do
        @customers_user = CustomersUser.new
        render 'new'
      end
    end
  end

  # GET /customers_users/1/edit
  def edit
    if access_private
      @customers_user = CustomersUser.find(params[:id])
      render :edit
    else
      redirect_to_root_unauthorized
    end
  end

  # POST /customers_users
  # POST /customers_users.json
  def create
    @customers_user = CustomersUser.new(customers_user_params)
    respond_to do |format|
      if @customers_user.save
        format.js do
          redirect_to controller: 'sessions',
                      action: 'create',
                      id: @customers_user.id,
                      email: @customers_user.email,
                      password: @customers_user.password
        end
        format.json { render :show, status: :created, location: @customers_user }
      else
        format.js { render "/customers_users/edit", status:  :bad_request}
      end
    end
  end

  # PATCH/PUT /customers_users/1
  # PATCH/PUT /customers_users/1.json
  def update
    if access_private
      respond_to do |format|
        @customers_user.attributes = customers_user_params
        if @customers_user.save
          format.html { redirect_to :index, notice: 'El usuario se actualizó correctamente' }
          format.js {   }
          format.json { render :show, status: :ok, location: @customers_user }
        else
          format.js { render "/customers_users/edit", status:  :bad_request}
          format.json { render json: @customers_user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to_root_unauthorized
    end

  end

  # DELETE /customers_users/1
  # DELETE /customers_users/1.json
  def destroy
    if access_private
      @customers_user.destroy
      respond_to do |format|
        format.html { redirect_to customers_users_url, notice: 'Customers user was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to_root_unauthorized
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def access_private
      current_customer.id.to_s == params[:id].to_s
    end
    def set_customers_user
      begin
        @customers_user = CustomersUser.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to_root_unauthorized
      end
      @customers_user
    end
    def redirect_to_root_unauthorized
      redirect_to controller: 'products',
                  action: 'index' , status: :unauthorized
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def customers_user_params
      params[:customers_user].permit(:first_name, :last_name,:email,:phone,:uid,:password,:password_confirmation)
    end
end
