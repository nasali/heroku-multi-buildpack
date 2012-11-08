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

def parse_release_vars(vars_string)
  if env_yaml.nil?
    env_yaml = YAML.load(vars_string)
  else
    yaml = YAML.load(vars_string)
    intersection = env_yaml.merge(yaml).slice(* ( env_yaml.keys & yaml.keys ) )
    puts "Intersection is #{intersection}"
    intersection.keys.each do |existing_key|
      env_yaml[existing_key].merge(yaml[existing_key])
    end
    new_vars = yaml.keys - intersection.keys
    new_vars.each do |key|
      env_yaml[key] = yaml[key]
    end
    puts "We made this:\n#{env_yaml.inspect}\n0000"
  end
end
def save_release_file
  file = File.new(RELEASES_FILE,'w')
  YAML.dump(env_yaml, file)
  file.close  
  puts "Using combined release:\n#{YAML.load(File.read(RELEASES_FILE))}"
end

def read_release_file
  YAML.load(File.read(RELEASES_FILE))
end