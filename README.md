# Client Search Application

This is a command-line application written in Ruby that allows you to:

- Search for clients based on a specified field and query.
- Identify duplicate client emails.

## Prerequisites

- Ruby (>= 3.0.0)
- RSpec (for testing)

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Install dependencies (RSpec):
   ```bash
   gem install rspec
   ```

## Usage

To run the application, use the following syntax:

```bash
ruby client_search_app.rb <command> <field> <query> [file]
```

### Commands

- `` — Dynamic Search clients by specified field and query.

  ```bash
  ruby client_search_app.rb search full_name "Jane" clients.json
  ruby client_search_app.rb search email "john.doe@gmail.com" clients.json
  ```

- `` — Find clients with duplicate emails.

  ```bash
  ruby client_search_app.rb duplicates clients.json
  ```

### Example Output

```
ID: 2 | Name: Jane Smith | Email: jane.smith@yahoo.com
ID: 3 | Name: Another Jane Smith | Email: jane.smith@yahoo.com
```

## Running Tests

To run the RSpec tests:

```bash
rspec client_search_spec.rb
```

## Notes

- If no file is provided, it defaults to `clients.json`.
- Ensure your JSON data follows the expected structure.