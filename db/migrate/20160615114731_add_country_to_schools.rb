class AddCountryToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :country, :string, limit: 3
  end
end
