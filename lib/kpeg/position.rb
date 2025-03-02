module KPeg
  module Position
    # STANDALONE START

    def current_column(target=pos)
      if c = string.rindex("\n", target-1)
        return target - c - 1
      end

      target + 1
    end

    if [].respond_to? :bsearch_index
      def current_line(target=pos)
        unless @line_offsets
          @line_offsets = []
          total = 0
          string.each_line do |line|
            total += line.size
            @line_offsets << total
          end
        end

        @line_offsets.bsearch_index {|x| x >= target } + 1 || -1
      end
    else
      def current_line(target=pos)
        cur_offset = 0
        cur_line = 0

        string.each_line do |line|
          cur_line += 1
          cur_offset += line.size
          return cur_line if cur_offset >= target
        end

        -1
      end
    end

    def lines
      lines = []
      string.each_line { |l| lines << l }
      lines
    end

    # STANDALONE END

  end
end
