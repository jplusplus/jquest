class AddCountryToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :country, :string, limit: 3
  end
end
