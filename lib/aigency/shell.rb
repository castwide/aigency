# frozen_string_literal: true

require 'fileutils'
require 'thor'

module Aigency
  # Top-level aigency commands for creating aigents.
  #
  class Shell < Thor
    map %i[new] => :enlist
    desc "enlist [DIRECTORY]", "Create an aigent directory"
    def enlist directory = 'aigent'
      puts "Installing aigent at #{directory}"
      if File.exist?(directory)
        if !File.directory?(directory)
          raise "#{directory} is not a directory."
        end
        if !Dir.empty?(directory)
          raise "#{directory} is not empty."
        end
      end
      FileUtils.mkdir(directory) unless File.directory?(directory)
      FileUtils.copy_entry(File.join(GEM_PATH, 'scaffold', 'enlist'), directory)
    end
  end
end
