class Failure
  attr_accessor :message

  def self.assert_equals object_1, object_2
    failure = Failure.new
    failure.message = assert_equals_fail_message object_1, object_2
    failure
  end

  def self.assert_not_null
    failure = Failure.new
    failure.message = assert_not_null_fail_message
    failure
  end

  private

  def initialize
  end

  def self.assert_equals_fail_message object_1, object_2
    "Assertion failed.\n" +
        "   Expected: <#{object_1.class.name}> #{object_1.nil? ? "nil" : object_1} \n" +
        "   Got: <#{object_2.class.name}> #{object_2.nil? ? "nil" : object_2} \n" +
        "in: #{caller[3]}\n"
  end

  def self.assert_not_null_fail_message
    "Assertion failed.\n" +
        "   Expected: Not nil \n" +
        "   Got: nil \n" +
        "in: #{caller[2]}\n"
  end

end