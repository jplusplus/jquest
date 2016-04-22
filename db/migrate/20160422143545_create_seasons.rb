class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :primary_color, default: '#373a3c'
      t.string :status, default: 'open'
      t.string :engine, default: nil
      t.timestamps
    end
  end
end
