require 'rubygems'
require 'google_drive'
require 'git'

GDRIVE_CONFIG = YAML.load_file("google.yml")

session = GoogleDrive.login(GDRIVE_CONFIG['username'], GDRIVE_CONFIG['password'])

sheet = session.spreadsheet_by_key(GDRIVE_CONFIG['spreadsheet_key']).worksheets[0]

# Gets content of A2 cell.y, x
puts sheet[2, 2]  #==> "hoge"

# Yet another way to do so.
#p sheet.rows  #==> [["fuga", ""], ["foo", "bar]]
