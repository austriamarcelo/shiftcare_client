require 'rspec'
require_relative 'client_search_app'

RSpec.describe ClientSearchApp do
  let(:test_data) do
    [
      { "id" => 1, "full_name" => "John Doe", "email" => "john.doe@gmail.com" },
      { "id" => 2, "full_name" => "Jane Smith", "email" => "jane.smith@yahoo.com" },
      { "id" => 3, "full_name" => "Another Jane Smith", "email" => "jane.smith@yahoo.com" }
    ]
  end

  let(:temp_file) do
    file = 'test_clients.json'
    File.write(file, test_data.to_json)
    file
  end

  subject { described_class.new(temp_file) }

  after { File.delete(temp_file) if File.exist?(temp_file) }

  describe '#search' do
    it 'finds clients matching the query in the specified field' do
      result = subject.search('full_name', 'Jane')
      expect(result.size).to eq(2)
      expect(result.map { |c| c['full_name'] }).to include('Jane Smith', 'Another Jane Smith')
    end

    it 'returns an empty array if no matches are found' do
      result = subject.search('full_name', 'Nonexistent')
      expect(result).to eq([])
    end
  end

  describe '#find_duplicates' do
    it 'finds clients with duplicate emails' do
      result = subject.find_duplicates
      expect(result.size).to eq(2)
      expect(result.map { |c| c['full_name'] }).to include('Jane Smith', 'Another Jane Smith')
    end

    it 'returns an empty array if no duplicates are found' do
      unique_data = [{ "id" => 4, "full_name" => "Unique User", "email" => "unique@gmail.com" }]
      File.write(temp_file, unique_data.to_json)

      result = subject.find_duplicates
      expect(result).to eq([])
    end
  end
end
