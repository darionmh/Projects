require_relative 'drive'
require_relative 'saveState.rb'
require 'pstore'


puts "Loading BasicOS"
@computer = Hash.new()
computer = @computer

savedFile = ""
quit = false
input = ""
computer["C"] = Drive.new("C")
currentDir = computer["C"]


def saveComp()
  stack = [@computer["C"]]
  continue = true
  while continue
    contents = stack.pop().getContents()
    contents.each{ |dirName, dir|
      puts(dirToText(dir))
      stack.push(dir)
      f = File.open(dirName+".txt", "w")
      f.puts(Marshal.dump(contents[dirName]))
      f.close()
      continue = (dir.getSize() > 0)?true:false
      }
  end
    
  f = File.open("save.txt", "w")  
  savedFile = Marshal.dump(@computer)
  f.puts(savedFile)
  f.close()
end

def loadComp()
  f = File.open("save.txt","r")
  data = f.read
  f.close()
  loadedFile = Marshal.load(data)
  puts(loadedFile)
  @computer.clear
  @computer.merge!(loadedFile)
  stack = [@computer["C"]]
  continue = true
  while continue
    contents = stack.pop().getContents()
    contents.each{ |dirName, dir|
      stack.push(dir)
      f = File.open(dirName+".txt", "r")
      data = f.read
      f.close()
      contents[dirName] = Marshal.load(data)
      puts(contents[dirName].getName())
      continue = (contents[dirName].getSize() > 0)?true:false
      }
  end
end

begin
  loadComp()
rescue
  puts("No previous state found. Blank computer will load.")
end


puts "BasicOS Loaded."
puts "Type 'help' for a list of available commands!\nType 'quit' to close."
commands = { 
  'mkdir' => "Creates a new folder in current directory", 
  'ls' => "Lists all contents of directory", 
  'del' => "Deletes current directory",
  'drives' => "Lists all drives",
  'save' => "Saves current state",
  'load' => "Loads last saved state",
  'cd' => "Changes current directory"
  }
  
while true
  print("-> ")
  input = gets.chomp.downcase
  
  case input   
    when 'mkdir'
      puts("Enter name of folder:" )
      dirName = gets.chomp
      currentDir.mkdir(dirName) 
      
    when 'ls'
      currentDir.ls()
      
    when 'del'
      puts("Enter name of folder: ")
      dirName = gets.chomp
      currentDir.del(dirName)
  
    when 'help'
      puts("Commands: ")
      commands.each{
        |command, desc|
        puts("\t '"+command+"': "+desc)
      }
      puts("")
      
    when 'save'
      saveComp()
      
    when 'load'
      loadComp()
      
    when 'cd'
      puts("Enter name of folder: ")
      dirName = gets.chomp
      currentDir = currentDir.cd(dirName)
    
    when 'quit'
      quit = true
        
    else
      puts("'"+input+"' is not a command")
      
  end
  
  if(quit)
    saveComp()
    break  
  end 
  puts("")
end


