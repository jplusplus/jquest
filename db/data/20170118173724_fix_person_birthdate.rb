class FixPersonBirthdate < SeedMigration::Migration
  def up
    # Collect id of every person where a sourced birthday have been provided
    ids = Source.where(resource_type: 'JquestPg::Person', field: 'birthdate').pluck(:id)
    # For every person, we have to look into the version
    JquestPg::Person.where(id: ids).where.not(birthdate: nil).find_each do |person|
      # Add one date to every birthdate
      person.update_attribute :birthdate, person.birthdate + 1.day
    end
  end

  def down
    # Not Implemented
  end
end
