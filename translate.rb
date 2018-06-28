#!/usr/bin/env ruby

module Translate
  class << self
    def translate_brainfuck(brainfuck_source_code)
      brainfuck_source_code.
        # gsub(/([^+\-<>,.\[\]\n]+)/, "#\\0\n").    # this attempts to comment out anything in a brainfuck program that is outside the valid command character set; however, it seems to be unnecessary, per https://esolangs.org/wiki/Brainfuck_algorithms#Header_comment
        tr(",.", "io")
    end

    def run
      print(translate_brainfuck(ARGF.read))
    end
  end
end

Translate.run if __FILE__ == $0