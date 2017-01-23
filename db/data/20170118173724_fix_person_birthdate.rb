class FixPersonBirthdate < SeedMigration::Migration
  def up
    # Collect id of every person where a sourced birthday have been provided
    ids = Source.where(resource_type: 'JquestPg::Person', field: 'birthdate').pluck(:resource_id)
    # To count updates
    counter = 0
    # Get every person witin those ids and with a birthday
    JquestPg::Person.where(id: ids).where.not(birthdate: nil).find_each do |person|
      # Add one date to every birthdate
      person.update_attribute :birthdate, person.birthdate + 1.day
      # Increment counter
      counter += 1
    end
    # Output updates count
    ActiveRecord::Migration::say "-- Updated #{counter} people"
  end

  def down
    # Collect id of every person where a sourced birthday have been provided
    ids = Source.where(resource_type: 'JquestPg::Person', field: 'birthdate').pluck(:resource_id)
    # To count updates
    counter = 0
    # Get every person witin those ids and with a birthday
    JquestPg::Person.eager_load(:versions).where(id: ids).where.not(birthdate: nil).find_each do |person|
      # Get birthday changes
      changes = person.versions.map{ |v| v.reify.birthdate }.compact.uniq
      # Did we add 1 day during the last 2 changes?
      if changes.length  > 1 and changes[-2].mjd - changes[-1].mjd === 1
        # So we can remove one day
        person.update_attribute :birthdate, person.birthdate - 1.day
        # Increment counter
        counter += 1
      end
    end
    # Output updates count
    ActiveRecord::Migration::say "-- Updated #{counter} people"
  end
end
