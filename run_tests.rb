require_relative './mechanic_tester'

MechanicTester.new.run([
  {
    steps: [ 'add(1,5)', 'add(8,9)' ],
    expected: [[1, 5], [8, 9]]
  },
  {
    steps: [ 'add(1,10)', 'remove(4,6)' ],
    expected: [[1, 4], [6, 10]]
  },
  {
    steps: [ 'add(1,5)', 'remove(2,3)', 'add(6,8)', 'remove(4,7)', 'add(2,7)' ],
    expected: [[1, 8]]
  },
])
