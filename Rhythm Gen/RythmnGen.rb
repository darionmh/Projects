require 'chunky_png'

notes = ['whole', 'half', 'quarter', 'eighth', 'sixteenth']
noteValue = [1, 0.5, 0.25, 1.0/8, 1.0/16]
notePics = 

puts "Enter the time signiture: (format- 4 4 or 3 4 or 6 8 etc)"
timeSigInput = gets.chomp.split(" ")
timeSig = timeSigInput[0].to_f/timeSigInput[1].to_f

puts "How many measures?: "
measures = gets.chomp.to_i

puts "How many times to generate?: "
times = gets.chomp.to_i

random = Random.new
until times == 0 do
  line = Array.new
  lineValues = Array.new
  width = 0
  for i in 0...measures
    
    temp = timeSig
    min = notes.size
    until temp == 0 do
      for n in noteValue.reverse
        if temp >= n
          min = noteValue.index(n)
        end
      end
      note = random.rand(min...notes.size)
      
      if noteValue[note] <= temp
        temp -= noteValue[note]
        if note == 3
        end
        line.push(ChunkyPNG::Image.from_file('media\\' + notes[note] + '.png'))
        lineValues.push(noteValue[note])
        width+=line[-1]::width
      end
    end
    if i < measures -1
      line.push(ChunkyPNG::Image.new(5, 128, ChunkyPNG::Color::BLACK))
      width+=line[-1]::width
    end
  end
  x = 0
  while x < lineValues.size
    if lineValues[x] == noteValue[3] && lineValues[x+1] == noteValue[3]
      line[x] = ChunkyPNG::Image.from_file('media\eighthStart.png')
      x+=1
      until lineValues[x] != noteValue[3] do
        line[x] = ChunkyPNG::Image.from_file('media\eighthMiddle.png')
        x+=1
      end
      line[x-1] = ChunkyPNG::Image.from_file('media\eighthEnd.png')
    else
      x+=1
    end    
  end
  
  lineImg = ChunkyPNG::Image.new((width*1.1).ceil, 128, ChunkyPNG::Color::WHITE)
  counter = 0
  for i in 0...line.size
    o = line[i]
    lineImg.compose!(o, counter)
    counter += o::width
  end
  lineImg.save('media\rhythms\line'+times.to_s+'.png', :fast_rgba)
  times -= 1
  line.clear
  width = 0
  lineValues.clear
  puts "#{times+1} is done."
  
end
