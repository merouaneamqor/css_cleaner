# frozen_string_literal: true

require_relative "css_cleaner/version"
require 'find'

module CssCleaner
  class Error < StandardError; end

  class Detector
    attr_reader :unused_classes

    def initialize
      @dynamic_classes = []
      @defined_classes = []
      @unused_classes = []
    end

    def parse_erb_haml
      pattern = /class=["']([^"']+)["']/
      Find.find('./') do |path|
        next unless ['.erb', '.haml'].include?(File.extname(path))
        File.open(path, 'r').each_line do |line|
          line.scan(pattern) do |match|
            @dynamic_classes.concat(match.first.split)
          end
        end
      end
    end

    def parse_js_coffeescript
      pattern = /\.addClass\(["']([^"']+)["']\)/
      Find.find('./') do |path|
        next unless ['.js', '.coffee'].include?(File.extname(path))
        File.open(path, 'r').each_line do |line|
          line.scan(pattern) do |match|
            @dynamic_classes.concat(match.first.split)
          end
        end
      end
    end

    def parse_css_scss
      pattern = /\.([^ ,:{]+)[ ,:{]/
      Find.find('./') do |path|
        next unless ['.css', '.scss'].include?(File.extname(path))
        File.open(path, 'r').each_line do |line|
          line.scan(pattern) do |match|
            @defined_classes << match.first
          end
        end
      end
    end

    # Detect and store unused classes
    def detect_unused_classes
      @unused_classes = @defined_classes - @dynamic_classes
    end

    # Main execution method
    def run
      parse_erb_haml
      parse_js_coffeescript
      parse_css_scss
      detect_unused_classes
      puts "Unused classes: #{@unused_classes.join(', ')}"
    end
  end
end
