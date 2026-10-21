# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

module Aigency
  module Tempdir
    require 'aigency/tempdir/helpers'
    require 'aigency/tempdir/list'
    require 'aigency/tempdir/read'
    require 'aigency/tempdir/write'
    require 'aigency/tempdir/size'

    PATH = Dir.mktmpdir
    TOOLS = [List, Read, Write, Size]

    at_exit { FileUtils.rm_rf PATH }
  end
end
