# frozen_string_literal: true

# Create error object
class ErrorDataRecord
  attr_reader :error_message, :status, :code

  def initialize(error_message, status, code)
    @error_message = error_message
    @status = status
    @code = code
  end
end
