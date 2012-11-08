TRIGGER_FILE_NAME = ".buildpacks"

WORK_DIR = ARGV[0]

TRIGGER_FILE = File.join(WORK_DIR,TRIGGER_FILE_NAME)

def log(message)
  puts "      #{message}"
end
