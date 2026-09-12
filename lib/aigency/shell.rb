# frozen_string_literal: true

require 'fileutils'
require 'thor'

module Aigency
  class Shell < Thor
    map %i[new] => :enlist
    desc "enlist [DIRECTORY]", "Enable the current user as an aigent"
    option :directory, type: :string, desc: 'Aigent directory', default: File.join(Dir.home, 'aigent')
    def enlist
      directory = options[:directory]
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
      FileUtils.copy_entry(File.join(GEM_PATH, 'scaffold'), directory)
    end
  end
end
