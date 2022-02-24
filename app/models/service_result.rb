class ServiceResult
  attr_reader :value, :errors

  private_class_method :new

  def initialize(value: nil, success: true, errors: [])
    @success = success
    @value = value
    @errors = errors.map { |msg| { message: msg } }
  end

  def self.error(error)
    errors([error])
  end

  def self.errors(errors)
    new(success: false, errors: errors)
  end

  def self.success(value)
    new(success: true, value: value)
  end

  def success?
    @success
  end
end
