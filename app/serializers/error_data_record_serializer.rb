# frozen_string_literal: true

# create hash of error object
class ErrorDataRecordSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialized_json
    {
      data: {
        status: @error_object.status,
        message: @error_object.error_message,
        code: @error_object.code
      }
    }
  end
end
