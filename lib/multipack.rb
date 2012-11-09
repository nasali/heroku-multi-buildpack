require 'yaml'
require 'fileutils'

WORK_DIR = ARGV[0]
CACHE_DIR = ARGV[1]

TRIGGER_FILE_NAME = ".buildpacks"
RELEASES_FILE_NAME = "releases_output.yml"

RELEASES_FILE = File.join(WORK_DIR,RELEASES_FILE_NAME)
TRIGGER_FILE = File.join(WORK_DIR,TRIGGER_FILE_NAME)
@env_yaml = nil
def log(message)
  puts "       #{message}"
end

def fix_executable_permissions(detect, compile, release)  
  `chmod +x #{detect} #{compile} #{release}`
end

def parse_release_vars(vars_string)
  if @env_yaml.nil?
    @env_yaml = YAML.load(vars_string)
  else
    yaml = YAML.load(vars_string)
    @env_yaml.merge!(yaml) do |key, old_value, new_value|
      if old_value.kind_of? Hash
        
        old_value.merge!(new_value) do |sub_key, sub_old_value, sub_new_value| 
          if sub_old_value.kind_of? Hash
            sub_old_value.merge!(sub_new_value)
          elsif sub_old_value.kind_of? Array
            sub_old_value << sub_new_value 
          elsif sub_old_value.kind_of? String
            sub_old_value << ":#{sub_new_value}"
          else
            raise "I do not know what to do with #{sub_old_value}"
          end
        end
        
      elsif old_value.kind_of? Array
        old_value << new_value 
      elsif old_value.kind_of? String
        old_value << ":#{new_value}"
      else
        raise "I do not know what to do with #{old_value}"
      end
    end
    puts "We made this:\n#{@env_yaml.inspect}\n0000"
  end
end
def save_release_file
  file = File.new(RELEASES_FILE,'w')
  YAML.dump(@env_yaml, file)
  file.close  
  puts "Using combined release:\n#{File.read(RELEASES_FILE)}"
end

def read_release_file
  File.read(RELEASES_FILE)
end