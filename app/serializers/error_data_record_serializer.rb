# frozen_string_literal: true

# create hash of error object
class ErrorDataRecordSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialized_json
    {
      errors: [
        {
          status: @error_object.status,
          messsage: @error_object.error_message,
          code: @error_object.code
        }
      ],
      code: @error_object.code
    }
  end
end
