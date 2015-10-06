require_relative 'document'

puts "document test"

doc = Document.new('Hamlet', 'Shakespareare', 'To be or not to be')

puts doc.words
puts doc.word_count


