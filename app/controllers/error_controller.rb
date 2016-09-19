class ErrorsController
  def not_found
    raise ActiveRecord::RecordNotFound
  end
end
