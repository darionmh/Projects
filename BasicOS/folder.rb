#Folder class
#Next level of storage down from Drive

class Folder
  
  def initialize(folderName, parent)
    @folder = Hash.new
    @folderName = folderName
    @parent = parent
  end
  
  def getName()
    return @folderName
  end
  
  def getSize()
    return @folder.length
  end
  
  def update(dirName, newValue)
    @folder[dirName] = newValue
  end
  
  def mkdir(dirName)
    if(@folder.has_key?(dirName))
      puts("Directory "+dirName+" already exists.")
      return false
    end
    
    @folder[dirName] = Folder.new(dirName, self)
    puts(dirName+" successfully created.")
    return true    
  end
  
  def ls()
    puts(@folderName+": ")
    
    @folder.each_key{
      |key|
      puts("\t"+key)
    }
    puts
  end
  
  def del(dirName)
    if(@folder.has_key?(dirName))
      input = ""
      loop do
        puts("Are you sure you want to delete "+dirName+"? (y/n)")
        input = gets.chomp.downcase
        break if(['y','n'].include?(input))
      end
      if(input == 'y')
        @folder.delete(dirName)
        puts(dirName+" successfully deleted.")
      else
        puts(dirName+" was not deleted.")
      end
      return true
    end
    return false
  end
  
  def cd(dirName)
    if(@folder.has_key?(dirName))
      return @folder[dirName]
    elsif(dirName == "..")
      if(@parent == nil)
        puts(@folderName+" has no parent directory")
        return self
      else
        return @parent
      end
    end
    puts("Directory '"+dirName+"' not found.")
    return self
  end 
  
  def getParent()
    return @parent
  end
  
  def getAddress()
    a = @folder
    str = ""
    while(a.getParent != nil)
      
    end
  end
  
  def getContents()
    return @folder
  end
  
  def to_s()
    string = "{"
    @folder.each{ |key, value|
      string+=key+", "
      }
    if(string[-2,string.length] == ", ")
      string = string[0,string.length-2]+"}"
    else
      string += "}"
    end
    return string
  end
end