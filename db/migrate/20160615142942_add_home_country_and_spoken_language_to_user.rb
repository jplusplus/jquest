class AddHomeCountryAndSpokenLanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :home_country, :string, limit: 3
    add_column :users, :spoken_language, :string
  end
end
