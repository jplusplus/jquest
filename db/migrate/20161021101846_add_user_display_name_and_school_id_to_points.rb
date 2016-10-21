class AddUserDisplayNameAndSchoolIdToPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :user_display_name, :text
    add_reference :points, :school, index: true
    # Migrate data to fill this 2 columns
    say_with_time "fill `user_display_name` and `school_id` columns..." do
      Point.eager_load(:user).find_each do |point|
        point.user_display_name = point.user.display_name
        point.school_id = point.user.school_id
        point.save
      end
    end
  end
end
