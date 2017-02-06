class AddIndexToCourseMaterialsStateName < ActiveRecord::Migration[5.0]
  def change
    add_index :course_materials, :state_name
  end
end
