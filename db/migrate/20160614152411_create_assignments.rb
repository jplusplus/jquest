class CreateAssignments < ActiveRecord::Migration
  def change
    # If the assignments structure is very close to activities', it does not
    # serve the same ppurpose at all. Assignments are made to save a user
    # assigment during a season. For instance, a resource to complete or a
    # data collection of any kind.
    create_table :assignments do |t|
      # All assignments are related to a user
      t.references :user, null: false, index: true, foreign_key: true
      # All assignments are related to a season
      t.references :season, null: false, index: true, foreign_key: true
      # ID of the resource this assignment might be related to
      t.references :resource, polymorphic: true
      # Type of the resource this assignment might be related to
      t.string :resource_type
      # This assignment may have an expiration date
      t.datetime :expires_at, index: true, null: true
      # This assignment may have a label
      t.string :label, null: true

      t.timestamps null: false
    end
  end
end
