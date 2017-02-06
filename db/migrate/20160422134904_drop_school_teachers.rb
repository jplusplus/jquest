class DropSchoolTeachers < ActiveRecord::Migration[5.0]
  def change
    drop_table :school_teachers
  end
end
