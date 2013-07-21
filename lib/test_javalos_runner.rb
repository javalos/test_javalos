require_relative 'failure'
require_relative 'printer'

class TestJavalosRunner
  attr_reader :exceptions, :failures, :total_passes

  def initialize
    @exceptions = Array.new
    @failures = Array.new
    @total_passes = 0
  end

  def start
    run_tests
    print_results
  end

  def test_passes
    Printer.test_passes
    @total_passes = total_passes + 1
  end

  def assert_equals_fails object_1, object_2
    Printer.test_fails
    failures << Failure.assert_equals(object_1, object_2)
  end

  def assert_not_null_fails
    Printer.test_fails
    failures << Failure.assert_not_null
  end

  def test_error_by exception
    Printer.test_error
    exceptions << exception
  end

  private

  def run_tests
    classes = ObjectSpace.each_object(Class).to_a
    test_classes = classes.find_all{|object_class| object_class.name =~ /(.*)Test$/ and object_class < TestJavalos }
    test_classes.each do |test_class|
      run_tests_for test_class
    end
  end

  def print_results
    Printer.results_for total_passes, failures, exceptions
  end

  def run_tests_for test_class
    instance = test_class.new(self)
    instance.before_all
    test_class.instance_methods.grep(/^test/).each do |method|
      run_method_test_with instance, method
    end
    instance.after_all    
  end

  def run_method_test_with instance, method
    begin
      instance.before_each
      instance.send(method)
    rescue => exception
      test_error_by exception
    ensure
      instance.after_each
    end
  end
end