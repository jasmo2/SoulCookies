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

class CustomersUser < Shoppe::Customer
  # include ActiveModel::MassAssignmentSecurity

  attr_accessor :password
  before_save :encrypt_password
  before_create { generate_token(:oauth_token) }

  validates_confirmation_of :password
  validates_presence_of  [:first_name, :last_name]
  validate :password_or_uid


  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  def self.authenticate(params)
    customer_user = find_by_email(params[:email])
    if customer_user && customer_user.password_hash == BCrypt::Engine.hash_secret( params[:password], customer_user.password_salt)
      customer_user
    else
      nil
    end
  end


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
    CustomerUserMailer.password_reset(self).deliver_now
  end

  def get_or_create_token
    unless oauth_token
      generate_token(:oauth_token)
      save!(:validate => false)
    end
    oauth_token
  end

  private
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while CustomersUser.exists?(column => self[column])
  end


  def password_or_uid
    if uid.blank? && password.blank?
      errors[:autenticacion] << "registrarse por facebook ó ingresar contraseña"
    end
  end

end
