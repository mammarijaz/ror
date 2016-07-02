class LineAnalyzer
  attr_reader :highest_wf_count,:highest_wf_words,:content,:line_number  
 
  def initialize(content,line_number)
      @content=content
      @line_number=line_number
      @highest_wf_words=Array.new()
      self.calculate_word_frequency()
  end

  def calculate_word_frequency
      frequency=Hash.new(0)
      words=@content.split(" ")
      words.each { |word| frequency[word.downcase] += 1 }
      #@highest_wf_count=frequency.max_by{|k,v| v}
      max = frequency.values.max
      @highest_wf_count=max
      temp=frequency.select { |k, v| v == max}
      temp.each do |key,value|
      	  @highest_wf_words.push(key)
      end	
      
      #@highest_wf_words=frequency.key(frequency.values.max)
      print @highest_wf_words   
  end

end

class Solution
  attr_reader :analyzers,:highest_count_across_lines,:highest_count_words_across_lines

  def initialize()
      @analyzers=Array.new 
  end
  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  def analyze_file()
      line_num=1
      text=File.open('test.txt').read
      text.gsub!(/\r\n?/, "\n")
      text.each_line do |line|
           line_analyzer=LineAnalyzer.new(line,line_num)
           line_num=line_num+1
           @analyzers.push(line_analyzer)
      end
  end
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  def calculate_line_with_highest_frequency()
      max=0
      @highest_count_words_across_lines=Array.new
      @analyzers.each do |line_analyzer|
          if line_analyzer.highest_wf_count > max
          	 max= line_analyzer.highest_wf_count
          end	 
      end
      @highest_count_across_lines=max
      @analyzers.each do |line_analyzer|
          if line_analyzer.highest_wf_count == max
         	 @highest_count_words_across_lines.push(line_analyzer)
          end	 
      end
     print @highest_count_words_across_lines 
  end

  def print_highest_word_frequency_across_lines()
  	  print "The following words have the highest word frequency per line:" 
  	  @highest_count_words_across_lines.each do |line_analyzer|  
          print "#{line_analyzer.highest_wf_words} (appears in line"+ '#' + "#{line_analyzer.line_number}\n)" 
      end
  end	
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
end

c = Solution.new
c.analyze_file()
c.calculate_line_with_highest_frequency()


