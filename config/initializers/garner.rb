require "garner/mixins/active_record"

module ActiveRecord
  class Base
    include Garner::Mixins::ActiveRecord::Base
  end
end
