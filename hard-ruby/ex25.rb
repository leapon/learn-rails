require "./ex25module.rb"

sentence = "All good things come to those who wait."
words = Ex25.break_words(sentence)
puts "words: #{words}"

sorted_words = Ex25.sort_words(words)
puts "sorted words: #{sorted_words}"

comment = """
Ex25.print_first_word(words)
Ex25.print_last_word(words)
Ex25.print_first_word(sorted_words)
Ex25.print_last_word(sorted_words)

Ex25.print_first_and_last(sentence)
Ex25.print_first_and_last_sorted(sentence)
"""

