class FailedLoginSerializer
  include FastJsonapi::ObjectSerializer
  attributes :invalid_credentials
end
