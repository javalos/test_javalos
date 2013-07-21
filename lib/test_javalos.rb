class TestJavalos

  def initialize(runner)
    @runner = runner
  end

  def j_assert_equals object_1, object_2
    if object_1 == object_2
      @runner.test_passes
    else
      @runner.assert_equals_fails object_1, object_2
    end
  end

  def j_assert_not_null object
    if not(object.nil?)
      @runner.test_passes
    else
      @runner.assert_not_null_fails
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
end