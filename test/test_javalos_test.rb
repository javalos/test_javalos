require 'test/unit'
require 'stringio'
require_relative '../lib/test_javalos'
require_relative '../lib/test_javalos_runner'

class TestJavalosTest < Test::Unit::TestCase

  def setup
    @runner = TestJavalosRunner.new
    @my_test = TestJavalos.new(@runner)
  end
  
  def test_pass_assert_equals_num
    execute { @my_test.j_assert_equals 1, 1 }
    assert_equal 1, @runner.total_passes
    assert_equal 0, @runner.failures.length
  end

  def test_fail_assert_equals_num
    execute { @my_test.j_assert_equals 1, 2 }
    assert_equal 0, @runner.total_passes
    assert_equal 1, @runner.failures.length
  end

  def test_pass_assert_equals_string
    execute { @my_test.j_assert_equals "hello world", "hello world" }
    assert_equal 1, @runner.total_passes
    assert_equal 0, @runner.failures.length
  end

  def test_fail_assert_equals_string
    execute { @my_test.j_assert_equals "hello world", "hello WORLD" }
    assert_equal 0, @runner.total_passes
    assert_equal 1, @runner.failures.length
  end

  def test_pass_assert_not_null
    execute { @my_test.j_assert_not_null "hello world" }
    assert_equal 1, @runner.total_passes
    assert_equal 0, @runner.failures.length
  end

  def test_fail_assert_not_null
    execute { @my_test.j_assert_not_null nil }
    assert_equal 0, @runner.total_passes
    assert_equal 1, @runner.failures.length
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