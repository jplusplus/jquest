class DropSchoolTeachers < ActiveRecord::Migration
  def change
    drop_table :school_teachers
  end
end
