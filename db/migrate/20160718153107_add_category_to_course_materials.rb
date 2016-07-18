class AddCategoryToCourseMaterials < ActiveRecord::Migration
  def change
    add_column :course_materials, :category, :string, index: true
  end
end
