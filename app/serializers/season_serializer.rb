class SeasonSerializer < ActiveModel::Serializer
  attributes  :id, :name, :primary_color, :status,
              :created_at, :updated_at, :engine
  def engine
    object.engine_info
  end
end
