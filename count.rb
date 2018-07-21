
# documents
docs = %w{pdf_source/progit_en.pdf pdf_source/progit_ru.pdf}

# check do them exists:
docs.each do |d|
    p `ls #{d}`
end