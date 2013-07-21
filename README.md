test_javalos
============

Ruby test framework developed for learning/practicing purposes.

Implemented methods
--------------------

    j_assert_equals param_1, param_2

    j_assert_not_null param_1

Installation
-------------
gem install test_javalos

Usage
------

1. Extend to `TestJavalos` class. The test class name should end with `Test`

2. Define test methods. The test method should start with `test`

3. Use the implemented methods

Example:

    require 'test_javalos'
    class MyClassTest < TestJavalos
    
      def test_my_method
        my_class = MyClass.new
        
        j_assert_equals "expected result", my_class.my_method
      end
      
    end

Execution
---------
Script to run the tests:

    test_runner = TestJavalosRunner.new
    test_runner.start

Output format:

    .
    1 assertions, 1 passed, 0 failed, with 0 errors
