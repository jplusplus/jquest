class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :contact_email
      t.string :contact_phone
      t.string :contact_name

      t.timestamps null: false
    end
  end
end
