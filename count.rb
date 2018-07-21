
# documents
docs = %w{pdf_source/progit_en.pdf pdf_source/progit_ru.pdf}

# check do them exists:
docs.each do |d|
    p `ls #{d}`
end

# convert pdf to text
# PDF to TXT pdf_source/progit_en.pdf: 73.22
# PDF to TXT pdf_source/progit_ru.pdf: 75.38
require 'benchmark'
require 'colorize'

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