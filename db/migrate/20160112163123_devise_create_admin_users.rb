class DeviseCreateAdminUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string   :email, null: false, default: ""
      t.string   :encrypted_password, null: false, default: ""
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      ## Rememberable
      t.datetime :remember_created_at
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      ## Omniauth
      t.string   :provider
      t.string   :uid
      ## Two-factor authenticatable
      t.string   :encrypted_otp_secret
      t.string   :encrypted_otp_secret_iv
      t.string   :encrypted_otp_secret_salt
      t.integer  :consumed_timestep, default: 0, null: false
      t.boolean  :otp_required_for_login, default: false, null: false
      ## General fields
      t.string   :role, default: "", null: false
      t.string   :phone_number, default: "", null: false
      ## Created at and Updated at
      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :provider
    add_index :users, :uid
  end
end
