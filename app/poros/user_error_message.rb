class UserErrorMessage
  attr_reader :id

  def initialize(user)
    @id = id
    @user = user
  end

  def error_message
    user.errors
  end

  def invalid_credentials
    'Invalid email or password'
  end

  def invalid_key
    'Unauthorized'
  end

  private

  attr_reader :user
end
