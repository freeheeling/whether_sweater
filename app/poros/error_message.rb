class ErrorMessage
  attr_reader :id

  def initialize(user)
    @id = id
    @user = user
  end

  def error_message
    user.errors
  end

  private

  attr_reader :user
end
