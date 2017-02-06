class CreateCourseMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :course_materials do |t|

      t.string :title
      t.string :state_name
      # This might contain a JSON definition of state's params.
      # We don't use the build-in json field for Postgres to maintain
      # the compatibility of the ORM with sqlite.
      t.text   :state_params, default: "{}"
      t.text   :body
      t.string :status, default: "draft", null: false

      t.timestamps null: false
    end
  end
end
