class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      # Field of the resource this source is related to
      t.string :field
      # ID of the resource this source is related to
      t.references :resource, polymorphic: true
      # Type of the resource this source is related to
      t.string :resource_type
      # Value of the source (URL, document name, book, etc)
      t.text :value

      t.timestamps null: false
    end

    add_index :sources, [:resource_type, :resource_id, :field]
  end
end
