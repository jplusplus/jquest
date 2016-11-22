class FillUsersCount < ActiveRecord::Migration[5.0]
  def change    
    # Migrate data to fill this column
    say_with_time "fill `*_count` column on User..." do
      # For every users
      User.find_each do |user|
        # Update the new fields
        user.activity_count = user.activities.count
        user.assignment_count = user.assignments.count
        user.save
      end
    end
  end
end
