class Printer

  def self.test_passes
    printf '.'
  end

  def self.test_fails
    printf 'F'
  end

  def self.test_error
    printf 'E'
  end

  def self.new_line
    puts ""
  end

  def self.results_for total_passes, failures, exceptions
    new_line
    if exceptions.length > 0
      print_exceptions exceptions
    end
    if failures.length > 0
      print_failures failures
    end
    print_summary total_passes, failures, exceptions
  end

  def self.print_exceptions exceptions
    puts "\nErrors:\n"
    exceptions.each_with_index do |exception, index|
      new_line
      puts (index + 1).to_s + ") " + exception.message
      puts "in " + exception.backtrace[0]
    end
    new_line    
  end

  def self.print_failures failures
    puts "\nFailures:\n"
    failures.each_with_index do |failure, index|
      new_line
      puts (index + 1).to_s + ") " + failure.message
    end
    new_line    
  end

  def self.print_summary total_passes, failures, exceptions
    puts "#{total_passes + failures.length} assertions, " +
          "#{total_passes} passed, " + 
          "#{failures.length} failed, " +
          "with #{exceptions.length} errors"
    new_line     
  end
end