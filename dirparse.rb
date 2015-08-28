dir = ARGV[0] || "."
if Dir.exist? dir
  data = Dir.entries(dir)
    .grep(/^U\d+_(Account|Activity|Position|Security)_\d{8}.txt/)
      .sort { |x, y| y<=>x }.group_by { |id| id[/U\d+/] }

  data.each { |key, val| data[key] = data[key].group_by { |date| date[/\d{8}/] } }

  data.each_pair do |id, val|
    puts id
    val.sort.each do |e|
      puts "  #{e.first[0..3]}-#{e.first[4..5]}-#{e.first[6..8]}"
      e.last.sort.each { |type| puts "    #{type[/(Account|Activity|Position|Security)/].downcase}" }
    end
  end
else
  puts "No is a directory: #{dir}."
end
