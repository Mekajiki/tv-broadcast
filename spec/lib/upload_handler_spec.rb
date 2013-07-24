#!/usr/bin/env ruby
require 'spec_helper'

describe Movie::UploadHandler do
  it 'can indicate duration from movie' do
    duration = Movie::UploadHandler.detect_duration '/storage/movies/f96485038d94dd4b2fbaaf0e128ef0f5.mp4'
    duration.should eq (28*60.0 + 52.36)
  end
end
