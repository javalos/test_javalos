class TestJavalos

  def self.run
    init
    run_tests
    print_messages
  end

  def assert_equals object_1, object_2
    increment_test_count
    if are_equals? object_1, object_2
      test_passes
    else
      assert_equals_fails object_1, object_2
    end
  end

  def assert_not_null object
    increment_test_count
    if not(object.nil?)
      test_passes
    else
      assert_not_null_fails
    end
  end

  private

  def self.init
    @@messages = Array.new
    @@count_tests = 0
  end

  def self.run_tests
    classes = ObjectSpace.each_object(Class).to_a
    test_classes = classes.find_all{|item| item.name =~ /(.*)Test/ }
    test_classes.each do |test_class|
      instance = test_class.new
      test_class.instance_methods.grep(/test/) { |method| instance.send(method)}
    end
  end

  def self.print_messages
    puts ""
    if @@messages.length > 0
      puts "\nFailures:\n"
      @@messages.each_with_index do |message, index|
        puts ""
        puts (index + 1).to_s + ") " + message
      end
      puts ""
    end
    puts "#{@@count_tests} tests, #{@@count_tests - @@messages.length} passed, #{@@messages.length} failed"
    puts ""
  end

  def increment_test_count
    @@count_tests = @@count_tests + 1
  end

  def are_equals? object_1, object_2
    (object_1 == object_2)
  end

  def test_passes
    printf '.'
  end

  def assert_equals_fails object_1, object_2
    printf 'F'
    @@messages << assert_equals_fail_message(object_1, object_2)
  end

  def assert_not_null_fails
    printf 'F'
    @@messages << assert_not_null_fail_message
  end

  def assert_equals_fail_message object_1, object_2
    "Assertion failed.\n" +
        "   Expected: <#{object_1.class.name}> #{object_1.nil? ? "nil" : object_1} \n" +
        "   Got: <#{object_2.class.name}> #{object_2.nil? ? "nil" : object_2} \n" +
        "in: #{caller[2]}\n"
  end

  def assert_not_null_fail_message
    "Assertion failed.\n" +
        "   Expected: Not nil \n" +
        "   Got: nil \n" +
        "in: #{caller[2]}\n"
  end
end

