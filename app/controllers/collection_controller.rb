class CollectionController < ActionController::Base
  require 'csv'

  @source = nil
  @model = Object

  def self.fetch(source=@source)
    csv_text = File.read(source)
    csv = CSV.parse(csv_text, :headers => true)
    all = []

    csv.each do |row|
      # Collect only attributes within the model
      hash = row.to_hash.select { |key, value| @model.method_defined? key }
      all << @model.new(hash)
    end

    return all
  end

  def self.all
    @vars ||= self.fetch
  end

  def self.names
    @names ||= self.uniq.collect &:name
  end

  def self.uniq
    self.all.uniq { |o| o.name }
  end

  def self.find(name=nil)
    if vars = all.select { |s| s.name == name || s.name.to_sym == name }
      vars[0]
    else
      nil
    end
  end
end
