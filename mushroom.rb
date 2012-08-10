require 'rubygems'
require 'google_drive'

GDRIVE_CONFIG = YAML.load_file("google.yml")

session = GoogleDrive.login(GDRIVE_CONFIG['username'], GDRIVE_CONFIG['password'])

sheet = session.spreadsheet_by_key(GDRIVE_CONFIG['spreadsheet_key']).worksheets[0]

row = sheet.rows[1]

date_from_sheet = row[0].split("/")

wod_date  = Date.parse("#{date_from_sheet[2]}-#{date_from_sheet[0]}-#{date_from_sheet[1]}")
wod       = row[1]
result    = row[2]
notes     = row[3]

system("git checkout gh-pages")

File.open("_posts/#{wod_date.strftime('%Y-%m-%d')}-workout-for-#{wod_date.strftime('%Y-%m-%d')}.markdown", 'w') do |workout|  
  workout.puts "---"
  workout.puts "layout: post"
  workout.puts "title: #{wod_date.strftime('%B %d, %Y')}"
  workout.puts "---"
  workout.puts "<p><b>Workout</b></p><p>#{wod.gsub(/\n/, '<br>')}</p>"
  workout.puts "<br/>"
  workout.puts "<p><b>Result</b></p><p>#{result.gsub(/\n/, '<br>')}</p>"
  workout.puts "<br/>"
  workout.puts "<p><b>Notes</b> #{notes.gsub(/\n/, '<br>')}"
end

system("git add .")
system("git commit", "-am", "Workout for #{wod_date.strftime('%Y-%m-%d')}")
system("git push origin gh-pages")
system("git checkout master")