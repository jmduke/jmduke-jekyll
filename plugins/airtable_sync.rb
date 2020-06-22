require 'json'
require 'airtable'
require 'active_support/all'

# Pass in api key to client
@client = Airtable::Client.new("keyX4yPY1qYqq1pad")

def paginate_indefinitely(table)
    all_results = []
    offset = nil
    while true
        page = table.records(:view => 'Grid view', :offset => offset)
        all_results += page.map(&:attributes)
        offset = page.offset
        break if offset.nil?
    end
    all_results
end


# Pass in the app key and table name
content_records = paginate_indefinitely(@client.table("app5RDJQQni8Itd2D", "Content"))
content_id_to_data = Hash[content_records.collect { |v| [v['id'], v] }]

notebook_records = paginate_indefinitely(@client.table("app5RDJQQni8Itd2D", "Notebook"))

notebook_records.each { |record|
    next unless record["source"]
    record["source"] = content_id_to_data[record["source"][0]]
}
# Change the filename here below but make sure it's in the _data folder.
File.open("_data/notebook.json", "w") do |f|
    f.write(notebook_records.to_json)
end