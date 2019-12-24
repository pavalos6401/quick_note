# Author: Pedro Jafet Avalos Jimenez
# Date:   2019-12-23

require_relative '../lib/quick_note.rb'

# Works
QuickNote.mkdir()
print "Task: "
task = gets.chomp
QuickNote.task(task)
QuickNote.optodo()