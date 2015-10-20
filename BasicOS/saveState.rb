require_relative 'drive'
require_relative 'folder'

def SaveState(drive)
  
end
  
def dirToText(dir)
  stringValue = "DirName: %{name}, Parent: %{parent}, Contents: %{contents}" % {:name => dir.getName(), :parent => dir.getParent().getName(),
    :contents => dir.to_s}
  return stringValue
end