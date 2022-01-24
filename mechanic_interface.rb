require 'singleton'

require_relative './mechanic_scheduler'

class InvalidInput < StandardError; end

class MechanicInterface
  include Singleton

  DEFAULT_NAME = 'Guest'

  attr_reader :name

  def initialize
    @name = nil
    @exit = false

    @scheduler = MechanicScheduler.new
  end

  def start
    wait_for_name

    loop do
      wait_for_command

      if @exit
        puts 'Okay, cya!'
        break
      end
    end
  end

  def wait_for_name
    puts 'Hi, What is your name? '
    @name = receive_input

    @name = DEFAULT_NAME if @name.empty?

    puts
    puts "Hi, #{name}!\n"
    puts 'I can manage intervals for integer numbers. I can add or remove intervals through methods.'
    puts
  end

  def wait_for_command
    puts 'What command do you want? e.g: add(1,5) or remove(2,3) (call \'exit\' to exit).'
    input = receive_input(downcase: true)

    if input == 'exit'
      exit_command
      return
    end

    command, from, to = parse_command(input)

    case command
    when 'add'
      add_command(from, to)
    when 'remove'
      remove_command(from, to)
    else
      unknown_command
    end
  rescue => e
    puts "[Error] #{e.message}"
  end

  def parse_command(input)
    match_data = /^(\w+)\((\d+),(\d+)\)$/.match(input)
    raise InvalidInput.new("Invalid input: #{input}") unless match_data

    command, from, to = match_data.captures

    command.downcase!
    from = from.to_i
    to = to.to_i

    unless MechanicScheduler::ALLOWED_COMMANDS.include?(command)
      raise InvalidInput.new("Unknown command: #{command}")
    end

    unless from < to
      raise InvalidInput.new("The first number must be smaller than the second number: #{values}")
    end

    if from <= 0 || to <= 0
      raise InvalidInput.new("The numbers must be positive: #{values}")
    end

    [command, from, to]
  end

  private

  def add_command(from, to)
    if @scheduler.add(from, to)
      puts "Interval [#{from}, #{to}] added successfully!"
      print '>> '
      @scheduler.print
    else
      puts "Error trying to add interval [#{from}, #{to}]"
    end
  end

  def remove_command(from, to)
    if @scheduler.remove(from, to)
      puts "Interval [#{from}, #{to}] removed successfully!"
      print '>> '
      @scheduler.print
    else
      puts "Error trying to remove interval [#{from}, #{to}]"
    end
  end

  def exit_command
    @exit = true
  end

  def unknown_command
    puts "#{command}? I don't know this command. Try again."
  end

  def receive_input(opts={})
    opts = {downcase: false}.merge(opts)

    text = $stdin.gets.chomp.strip
    text.downcase! if opts[:downcase]

    text
  end
end
