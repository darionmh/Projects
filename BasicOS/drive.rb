#Drive class
#Highest level of heirarchy

require_relative 'folder'

class Drive
 
  def initialize(driveName)
    @drive = Folder.new(driveName, nil)
    @driveName = driveName
  end
  
  def getName()
    return @driveName
  end
  
  def getSize()
    return @drive.getSize()
  end
  
  def update(dirName, newValue)
    @drive.update(dirName, newValue)
  end
  
  #Method to create a new folder
  def mkdir(dirName)
    @drive.mkdir(dirName)   
  end
  
  #Lists all folders in directory
  def ls()
    @drive.ls()
  end
  
  #Deletes directory
  def del(dirName)
    @drive.del(dirName)
  end
  
  def cd(dirName)
    return @drive.cd(dirName)
  end
  
  def getContents
    return @drive.getContents
  end
  
  def to_s()
    return @drive.to_s()
  end
  
end