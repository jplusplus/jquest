class AddHomeCountryAndSpokenLanguageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :home_country, :string, limit: 3
    add_column :users, :spoken_language, :string
  end
end
