require 'benchmark'
require 'colorize'
# documents
docs = %w{pdf_source/progit_en.pdf pdf_source/progit_ru.pdf}

# check do them exists:
docs.each do |d|
    puts File.file?(d) ? "#{d} exists".green : "#{d} not exists"
end

# convert pdf to text
# PDF to TXT pdf_source/progit_en.pdf: 73.22
# PDF to TXT pdf_source/progit_ru.pdf: 75.38


docs.each do |d|
    puts "Convert PDF to TXT #{d}:".green
    time = Benchmark.measure {
        if ! File.file?(d+".txt")
         p `ruby pdf2txt.rb #{d}`
        else
            puts "#{d}.txt already converted".red
        end
    }
    puts  ("PDF to TXT #{d}: %.2f" % time.real).magenta
end

def count_words(file_name)
    puts "#{file_name}".green
    lines =  File.readlines(file_name)
    puts "ENGLISH words:".red
    words = lines.reduce(:+).split.select{|x| /^[a-zA-Z]+$/ === x}.map{|x| x.downcase}.uniq.sort
    puts "Total words:".green
    p words.size
    puts "First 10 words:".green
    p words[1..10]
    puts "Last 10 words:".green
    p words[-10..-1]
    puts "RUSSIAN words:".red
    words = lines.reduce(:+).split.map{|x| x.downcase}.select{|x| /^[а-я]+$/ === x}.uniq.sort
    puts "Total words:".green
    p words.size
    puts "First 10 words:".green
    p words[1..10]
    puts "Last 10 words:".green
    p words[-10..-1]
end

# Count numer of words
docs.each do |d|
    puts "Count numer of words #{d}:".green
    time = Benchmark.measure {
        count_words(d+".txt")
    }
    puts  ("Count numer of words #{d}: %.2f" % time.real).magenta
end