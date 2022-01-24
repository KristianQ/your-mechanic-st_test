## Overview

The Mechanic Scheduler manages a list representing disjointed intervals of integers.

## Example

```bash
$ ruby run.rb 
Hi, What is your name? 
John

Hi, John!
I can manage intervals for integer numbers. I can add or remove intervals through methods.

What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
add(1,5)
Interval [1, 5] added successfully!
>> [[1, 5]]
What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
remove(2,3)
Interval [2, 3] removed successfully!
>> [[1, 2], [3, 5]]
What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
add(6,8)
Interval [6, 8] added successfully!
>> [[1, 2], [3, 5], [6, 8]]
What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
remove(4,7)
Interval [4, 7] removed successfully!
>> [[1, 2], [3, 4], [7, 8]]
What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
add(2,7)
Interval [2, 7] added successfully!
>> [[1, 8]]
What command do you want? e.g: add(1,5) or remove(2,3) (call 'exit' to exit).
exit
Okay, cya!
```

## How to run

Execute the file `run.rb` using the ruby executable:

```bash
$ ruby run.rb
```

To run the automated tests, run the file `run_tests.rb` using the ruby executable:

```bash
$ ruby run_tests.rb 
...
examples: 3, failed: 0
```

## Documentation

### Mechanic Scheduler

> This class manages a list of intervals, with methods for
  adding, removing and printing the list

```ruby
@scheduler = MechanicScheduler.new

@scheduler.add(1, 5)
@scheduler.remove(2, 3)
@scheduler.print
```

### Mechanic Interface

> This class can be used as an interface to receive user's input

```ruby
@interface = MechanicInterface.instance

@interface.start
```

### Mechanic Tester

> This class can be used to run automated tests

```ruby
@tester = MechanicTester.new

@teser.run([
  {
    steps: [ 'add(1,5)', 'add(8,9)' ],
    expected: [[1, 5], [8, 9]]
  }
])
```
