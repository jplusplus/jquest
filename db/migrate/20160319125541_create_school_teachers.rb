class CreateSchoolTeachers < ActiveRecord::Migration
  def change
    create_table :school_teachers do |t|
      t.references :school, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
