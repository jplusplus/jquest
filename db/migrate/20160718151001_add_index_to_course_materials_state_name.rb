class AddIndexToCourseMaterialsStateName < ActiveRecord::Migration
  def change
    add_index :course_materials, :state_name
  end
end
