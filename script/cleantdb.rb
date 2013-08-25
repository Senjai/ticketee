print "This will WIPE your database. Continue? (y/n): "

if $stdin.gets.chomp.downcase == "y"
  # iterate over all model definition files
  Dir["#{Rails.root}/app/models/**/*.rb"].map do |model_filename|
    # get the file base_name
    model_file_basename = File.basename(model_filename,File.extname(model_filename))
    # get the model class from the file basename
    model_class = model_file_basename.camelize.constantize
    # ask the model (ActiveRecord::Base subclass) to give you its table_name
    table_name = model_class.table_name
    # wipe the table
    puts "Wiping table #{table_name}.."
    ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{table_name};"
  end
else
  puts "Terminating script..."
end