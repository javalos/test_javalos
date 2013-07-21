require 'test/unit'
require 'stringio'
require_relative '../lib/test_javalos'
require_relative '../lib/test_javalos_runner'

class TestJavalosRunnerTest < Test::Unit::TestCase

  class MyClassTest < TestJavalos
    def test_one
      j_assert_equals 1, 1
      3.a #should add an exception
      j_assert_equals 2, 2 # test doesn't reach here
    end    

    def test_two
      j_assert_equals 2, 2
      j_assert_equals 1, 2
      j_assert_equals 1, 3
    end
  end

  class OtherClassTest < TestJavalos
    def test_three
      j_assert_equals 3, 3
    end
  end
  
  def test_assert_equals
    runner = TestJavalosRunner.new
    execute { runner.start }
    assert_equal 3, runner.total_passes
    assert_equal 1, runner.exceptions.length
    assert_equal 2, runner.failures.length
  end

  def test_runner_methods
    runner = TestJavalosRunner.new
    assert_respond_to(runner, :start)
    assert_respond_to(runner, :test_passes)
    assert_respond_to(runner, :assert_equals_fails)
    assert_respond_to(runner, :assert_not_null_fails)
    assert_respond_to(runner, :test_error_by)
  end

  def execute(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
   fake.string
  end
end