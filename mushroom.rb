require 'rubygems'
require 'google_drive'
require 'git'

GDRIVE_CONFIG = YAML.load_file("google.yml")

session = GoogleDrive.login(GDRIVE_CONFIG['username'], GDRIVE_CONFIG['password'])

sheet = session.spreadsheet_by_key(GDRIVE_CONFIG['spreadsheet_key']).worksheets[0]

row = sheet.rows[1]

date_from_sheet = row[0].split("/")

wod_date  = Date.parse("#{date_from_sheet[2]}-#{date_from_sheet[0]}-#{date_from_sheet[1]}")
wod       = row[1]
notes     = row[2]

#g = Git.init
#g.branch('gh-pages').checkout

system("git checkout gh-pages")

File.open("_posts/#{wod_date.strftime('%Y-%m-%d')}-workout.markdown", 'w') do |workout|  
  workout.puts wod
  workout.puts "<br/>"
  workout.puts notes
end

#g.add(".")
#g.commit("Workout for #{wod_date.strftime('%Y-%m-%d')}")
#g.push
#g.branch('master').checkout

system("git add .")
system("git commit", "-a -m", "Workout for #{wod_date.strftime('%Y-%m-%d')}")
system("git push origin gh-pages")
system("git checkout master")