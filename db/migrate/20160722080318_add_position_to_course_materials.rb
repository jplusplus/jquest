class AddPositionToCourseMaterials < ActiveRecord::Migration
  def change
    add_column :course_materials, :position, :integer, default: 0
  end
end
