class ChangeUsersTable < ActiveRecord::Migration
  def change
    remove_columns :users, :first_name, :last_name, :email, :password_digest
    add_column :users, :name, :string
    add_column :users, :score, :integer
    add_column :users, :position, :integer
  end
end
