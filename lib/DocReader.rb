class DocReader
  def initialize
    @heading  = ''
    @if_error = ''
    @intro = ''
    @steps = []
  end

  def parse_copytext filename
    begin
      @enum = File.open(filename).each
      while @enum.peek
        case next_line
          when /---heading/
            @heading += next_line until reached?(/---if-error/)
          when /---if-error/
            @if_error += next_line until reached?(/---intro/)
          when /---intro/
            @intro += next_line until reached?(/---steps/)
          when /---steps/
            next_line_contains_more_than_whitespace? ? @steps << next_line : next_line until reached?(/---closing/)
        end
      end
    ensure
      return {heading:@heading, if_error:@if_error, intro:@intro, steps:@steps}
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