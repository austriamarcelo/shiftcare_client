require 'json'

class ClientSearchApp
  def initialize(file)
    @clients = JSON.parse(File.read(file))
  end

  def search(field, query)
    results = @clients.select { |client| client[field]&.downcase&.include?(query.downcase) }
    results
  end

  def find_duplicates
    @clients.group_by { |client| client["email"] }
            .select { |_, group| group.size > 1 }
            .values.flatten
  end
end

# Command-line interface
if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: ruby client_search_app.rb <command> <field> <query> [file]"
    puts "Commands:"
    puts "  search <field> <query> [file] - Search clients by specified field"
    puts "  duplicates [file]             - Find clients with duplicate emails"
    exit
  end

  file = ARGV[3] || 'clients.json'
  app = ClientSearchApp.new(file)

  case ARGV[0]
  when 'search'
    results = app.search(ARGV[1], ARGV[2] || "")
    if results.empty?
      puts "No results found."
    else
      results.each { |client| puts "ID: #{client["id"]} | Name: #{client["full_name"]} | Email: #{client["email"]}" }
    end
  when 'duplicates'
    results = app.find_duplicates
    if results.empty?
      puts "No duplicates found."
    else
      results.each { |client| puts "ID: #{client["id"]} | Name: #{client["full_name"]} | Email: #{client["email"]}" }
    end
  else
    puts "Invalid command. Use 'search' or 'duplicates'."
  end
end
