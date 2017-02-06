class AddUserGroup < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :group, index: true
  end
end
