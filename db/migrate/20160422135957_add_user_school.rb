class AddUserSchool < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :school, index: true
  end
end
