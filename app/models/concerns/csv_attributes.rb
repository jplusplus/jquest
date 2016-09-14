module CsvAttributes
  extend ActiveSupport::Concern

  included do
    def self.csv_attributes
      if defined?(super)
        super
      else
        ['id']
      end
    end

    def self.csv_attribute_reflected?(attr)
      not reflections[attr].nil?
    end

    def self.csv_attributes_in_reflection
      csv_attributes.select do |attr|
        csv_attribute_reflected? attr
      end
    end

    def self.csv_attributes_associated
      attributes = []
      csv_attributes_in_reflection.each do |attr|
        # Does the association defined CSV attributes?
        if reflections[attr].klass.respond_to? :csv_attributes_literal
          # If not, we use its id
          reflections[attr].klass.csv_attributes_literal.each do |child|
            attributes << "#{attr}__#{child}"
          end
        end
      end
      attributes
    end

    def self.csv_attributes_literal
      attributes = csv_attributes.map do |attr|
        # Is the given attribute an association?
        if csv_attribute_reflected?(attr)
          # Does the association defined CSV attributes?
          unless reflections[attr].klass.respond_to? :csv_attributes_literal
            # If not, we use its id
            "#{attr}_id"
          end
        # Literal value
        else
          attr
        end
      end
      # Remove nil value
      attributes.compact
    end

    def self.csv_attributes_all
      csv_attributes_literal + csv_attributes_associated
    end

    def self.sliced_each(batch_size: 1000)
      # Shortcut to limit value (if any)
      limit_value = all.limit_value || count
      offset_value = all.offset_value || 0
      # Only a slice, bigger than the batch size
      if limit_value > batch_size
        # Loop a fixed number of times
        (limit_value/batch_size.to_f).ceil.times do |index|
          # Calculate offset and limit dynamicly using batch size,
          # current index and original offset value
          offset = offset_value + index * batch_size
          limit = [limit_value - index * batch_size, batch_size].min
          # Iterate over a given batch
          offset(offset).limit(limit).each { |o| yield o }
        end
      else
        all.each { |o| yield o }
      end
    end

    def self.to_csv
      CSV.generate(headers: true) do |csv|
        attributes = csv_attributes_all
        # Add headers
        csv << attributes
        # For all given object
        all.sliced_each do |object|
          values = []
          # Get all literal values
          values += csv_attributes_literal.map do |attr|
            object.send(attr)
          end
          # Get all associated values
          values += csv_attributes_associated.map do |attr|
            literal = object
            # Look into the object child
            attr.split('__').each do |child|
              literal = literal.send(child)
            end
            literal
          end
          # Add all value
          csv << values
        end
      end
    end
  end
end
