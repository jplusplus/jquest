Rails.application.config.after_initialize do
  PaperTrail.config.track_associations = false
end
