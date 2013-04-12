class Author
  attr_accessor :name, :institutions, :institution_numbers
  def initialize(name, institutions)
    @name = name
    @institutions= institutions
  end
  def to_s
    "#{@name},#{@institutions}"
  end
end

def clean all_text
  # remove double commas, as this is a common, and difficult to spot, error in author lists...
  all_text.gsub!(',,', ',')
  # find first [ and add a symbol to be able to split at it.
  all_text.sub!('[', '#[')
  # split at the # we just added
  parts = all_text.split('#')
  # the first part is the authors
  authors_string = parts[0]
  # the second part is the institutions
  institutions_string = parts[1].strip
  # make the strings more "parsable" for later
  authors_string = authors_string.strip.concat(",").gsub(/([0-9,]+)[,||$]\s*/, ("|\\1\n".sub(",",";")))
  institutions_string.gsub!("[","\n[")
  institutions_string.gsub!(";","")
  # institutions is a hashmap from institution number to institution name
  institutions = Hash.new
  # fill the map of institutions
  institutions_string.each_line do |line|
    line=~/\[([0-9]+)\]\s*(.*)$/
    institutions[$1.to_i]=$2.strip unless $1==nil
  end
  # generate list of authors and affiliations
  authors = []
  authors_string.each_line do |line|
    elems = line.split("|")
    insts = []
    elems[1].split(",").each do |e|
      insts.push(institutions[e.to_i])
    end
    authors.push(Author.new(elems[0],insts))
  end
  # set up a map of institutions in the paper so far to their respective indexes
  institutions_in_paper = Hash.new
  start_index = 1
  # start the (vey basic) html_string
  html_string = "<html><body><p style=\"text-align: center;\"><b>"
  # add the authors one by one
  authors.each do |author|
    indexes = []
    author.institutions.each do |inst|
      index = institutions_in_paper[inst]
      if index == nil
        index = institutions_in_paper.length+start_index
        institutions_in_paper[inst] = index
      end
      indexes.push index
    end
    indexes.sort!
    author.institution_numbers = indexes
    # create string of indexes
    index_string = indexes[1,indexes.length-1].inject(indexes[0].to_s){|result, element| result+","+element.to_s}
    # append this author to the html_string
    html_string.concat("#{author.name}<sup>#{index_string}</sup>, ")
  end
  # Delete the last ',' added
  html_string = html_string.reverse.sub(" ,","").reverse
  # Beautify things
  html_string.concat("<br><br>")
  # Add the institutions
  institutions_in_paper.keys.each do |inst|
    html_string.concat("[#{institutions_in_paper[inst]}] #{inst}; ")
  end
  # Delete the last ';' added
  html_string = html_string.reverse.sub(" ;","").reverse
  # Finalize the html
  html_string.concat("</p></b></body></html>")
end