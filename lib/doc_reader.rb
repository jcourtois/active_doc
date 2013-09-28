class DocReader

  #token parser: (alternative to case) identify tokens and then delegate to them

  def parse_copytext filename
    title = ''; heading  = ''; if_error = ''; intro = ''; steps = []
    begin
      @enum = File.open(filename).each
      while @enum.peek
        #TokenParser.from(next_line).parse(next_line)
        case next_line
          when /---title/
            title += next_line.chomp until reached?(/---heading/)
          when /---heading/
            heading += next_line.chomp until reached?(/---if-error/)
          when /---if-error/
            if_error += next_line.chomp until reached?(/---intro/)
          when /---intro/
            intro += next_line.chomp until reached?(/---steps/)
          when /---steps/
            next_line_contains_more_than_whitespace? ? steps << next_line.chomp : next_line until reached?(/---closing/)
        end
      end
    ensure
      return {title:title, heading:heading, if_error:if_error, intro:intro, steps:steps}
    end
  end

  def parse_formatting filename
    css = ''; js = ''; header = '';
    begin
      @enum = File.open(filename).each
      while @enum.peek
        case next_line
          when /---css/
            css += next_line.chomp until reached?(/---js/)
          when /---js/
            js += next_line.chomp until reached?(/---header/)
          when /---header/
            header += next_line.chomp until reached?(/---end/)
        end
      end
    ensure
      return {css:css, js:js, header:header}
    end
  end

  def next_line_contains_more_than_whitespace?
    @enum.peek =~ /[^ \t\r\n\f]/
  end

  def next_line
    @enum.next
  end

  def reached?(reg_ex)
    !(@enum.peek && @enum.peek !~ reg_ex)
  end
end