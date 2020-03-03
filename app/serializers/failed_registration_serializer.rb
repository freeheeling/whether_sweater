class FailedRegistrationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :error_message
end
