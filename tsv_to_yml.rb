# frozen_string_literal: true

require 'yaml'
require 'csv'

def print_yaml
  file_hashed = read_tsv
  puts file_hashed.to_yaml
end

def create_yaml
  file_hashed = read_tsv
  File.open(ARGV[1], 'w') do |file|
    file.puts file_hashed.to_yaml
  end
end

def read_tsv
  file_open = CSV.table(ARGV[0], col_sep: "\t")
  file_hashed = file_open.map(&:to_hash)
  file_hashed.each do |hash|
    hash.keys.map { |key| hash[key.to_s] = hash.delete(key) }
    hash['student_id'] = hash['student_id'].to_s
    hash['tech_experience'] += "\r"
  end
end

ARGV[1].nil? ? print_yaml : create_yaml
