# frozen_string_literal: true

require 'yaml'

def read_yaml
  file_yaml = YAML.load_file(ARGV[0])
  file_keys = file_yaml[0].keys
  lines = file_keys.reduce { |key1, key2| "#{key1}\t#{key2}" }
  file_yaml.each do |col|
    lines += "\n"
    lines += col.values.reduce { |value1, value2| "#{value1}\t#{value2}" }
  end
  lines
end

def create_tsv
  file_string = read_yaml
  File.open(ARGV[1], 'w') do |file|
    file.puts file_string
  end
end

create_tsv
