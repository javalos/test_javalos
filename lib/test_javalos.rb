class TestJavalos

  def self.run
    init
    run_tests
    print_messages
  end

  def assert_equals object_1, object_2
    increment_total_assertions
    if are_equals? object_1, object_2
      test_passes
    else
      assert_equals_fails object_1, object_2
    end
  end

  def assert_not_null object
    increment_total_assertions
    if not(object.nil?)
      test_passes
    else
      assert_not_null_fails
    end
  end

  def before_all
  end

  def after_all
  end

  def before_each
  end

  def after_each
  end

  private

  def self.init
    @@errors = Array.new
    @@messages = Array.new
    @@total_assertions = 0
  end

  def self.run_tests
    classes = ObjectSpace.each_object(Class).to_a
    test_classes = classes.find_all{|object_class| object_class.name =~ /(.*)Test$/ and object_class < TestJavalos }
    test_classes.each do |test_class|
      run_tests_for test_class
    end
  end

  def self.run_tests_for test_class
    instance = test_class.new
    instance.before_all
    test_class.instance_methods.grep(/^test/).each do |method|
      run_method_test_with instance, method
    end
    instance.after_all    
  end

  def self.run_method_test_with instance, method
    begin
      instance.before_each
      instance.send(method)
    rescue => exception
      test_error_by exception
    ensure
      instance.after_each
    end
  end

  def self.test_error_by exception
    printf 'E'
    @@errors << exception
  end

  def self.print_messages
    puts ""
    if @@errors.length > 0
      puts "\nErrors:\n"
      @@errors.each_with_index do |error, index|
        puts ""
        puts (index + 1).to_s + ") " + error.message
        puts error.backtrace
      end
      puts ""
    end
    if @@messages.length > 0
      puts "\nFailures:\n"
      @@messages.each_with_index do |message, index|
        puts ""
        puts (index + 1).to_s + ") " + message
      end
      puts ""
    end
    puts "#{@@total_assertions} assertions, " +
          "#{@@total_assertions - @@messages.length} passed, " + 
          "#{@@messages.length} failed, " +
          "with #{@@errors.length} errors"
    puts ""
  end

  def increment_total_assertions
    @@total_assertions = @@total_assertions + 1
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

