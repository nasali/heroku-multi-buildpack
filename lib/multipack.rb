require 'yaml'
require 'fileutils'

WORK_DIR = ARGV[0]
CACHE_DIR = ARGV[1]

TRIGGER_FILE_NAME = ".buildpacks"
RELEASES_FILE_NAME = "releases_output.yml"

RELEASES_FILE = File.join(WORK_DIR,RELEASES_FILE_NAME)
TRIGGER_FILE = File.join(WORK_DIR,TRIGGER_FILE_NAME)

def log(message)
  puts "       #{message}"
end

def fix_executable_permissions(detect, compile, release)  
  `chmod +x #{detect} #{compile} #{release}`
end

def save_release_file(env_vars)
    puts "Dumping #{env_vars} \nto file"
  file = File.new(RELEASES_FILE,'w')
  YAML.dump(env_vars, file)
  file.close  
    
    puts "READING what we just wrote is#{YAML.load(File.read(RELEASES_FILE)).inspect}"
end

def read_release_file
  YAML.load(File.read(RELEASES_FILE))
end