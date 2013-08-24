MODEL_DIR = File.expand_path("app/models")

Dir.chdir(MODEL_DIR)
files = Dir.glob(File.join("**", "*.rb"))

files.map! do |file|
  file[0..-4].pluralize
end

print "This will WIPE your database. Continue? (y/n): "
if $stdin.gets.chomp.downcase == "y"
  files.each do |f|
    puts "Wiping #{f}.."
    ActiveRecord::Base.connection.execute "TRUNCATE TABLE #{f};"
  end
else
  puts "Terminating script..."
end