#!/usr/bin/env ruby
require 'spec_helper'

describe Program do
  it 'can be instantiated from epg dictionary' do
    epg_dictionary = JSON.parse(File.read('spec/resources/epg.json'))

    program = Program.new_from_epg epg_dictionary[0]['programs'][0]
    program.movie_path = 'hoge'
    binding.pry
    program.save.should be_true
  end
end
