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

class CustomersUser < Shoppe::Customer
  # include ActiveModel::MassAssignmentSecurity

  attr_accessor :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end


end
