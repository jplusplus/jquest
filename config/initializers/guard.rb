if Rails.env.development?
  require 'guard'
  # needed because of https://github.com/guard/guard/issues/793
  require 'guard/commander'

  # Start Guard only with rails.
  if File.basename($0, '.*') == 'rails'
    fork do
      if __FILE__ == '(irb)'
      end

      # Guard.guards 'sass'
      Guard.start :no_interactions => true
    end
  end
end
