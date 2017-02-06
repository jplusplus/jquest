class AddCategoryToCourseMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :course_materials, :category, :string, index: true
  end
end
