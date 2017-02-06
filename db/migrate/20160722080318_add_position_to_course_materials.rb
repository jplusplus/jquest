class AddPositionToCourseMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :course_materials, :position, :integer, default: 0
  end
end
