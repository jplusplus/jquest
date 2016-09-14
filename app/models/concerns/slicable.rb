module Slicable
  extend ActiveSupport::Concern

  included do

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

  end
end
