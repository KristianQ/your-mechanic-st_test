require_relative './mechanic_scheduler'
require_relative './mechanic_interface'

class MechanicTester
  def initialize
    @scheduler = MechanicScheduler.new
    @interface = MechanicInterface.instance

    @failed = []
  end

  def run(specs)
    @failed = []

    specs.each do |spec|
      @scheduler.reset

      spec[:steps].each do |step|
        @scheduler.send(*@interface.parse_command(step))
      end

      if @scheduler.list == spec[:expected]
        print '.'
      else
        print 'F'
        @failed << { spec: spec, expected: spec[:expected], actual: @scheduler.list }
      end
    end

    puts
    puts "examples: #{specs.size}, failed: #{@failed.size}"

    @failed.each do |fail|
      puts "Spec #{fail[:spec]} failed."
      puts "Expected: #{fail[:expected]}, but received #{fail[:actual]}."
      puts
    end
  end
end
