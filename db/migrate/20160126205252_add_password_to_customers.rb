class AddPasswordToCustomers < ActiveRecord::Migration
  def change
    add_column :shoppe_customers, :password_hash, :string
    add_column :shoppe_customers, :password_salt, :string

  end
end
