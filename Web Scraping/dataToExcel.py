from xlwt import Workbook

oilData = []
headers = []
f = open("edensgarden.txt","r")
for line in f:
    if line == "\n":
        continue
    oil = line.split("&")
    oilData.append(oil)
    for o in oil:
        if ":" in o:
            header = o.replace(":","")
            if header not in headers:
                headers.append(header)
    
book = Workbook()
sheet1 = book.add_sheet("Sheet 1")

index = 0
for h in headers:
    sheet1.write(0,index,h)
    index+=1
    
row = 1
temp = ""
for oil in oilData:
    header = ""
    for data in oil:
        if ":" in data:
            header = data.replace(":","")
            continue
        if oil.index(data) < len(oil)-1:
            if ":" in oil[oil.index(data)+1]:
                sheet1.write(row,headers.index(header),(data+"\n"+temp).strip())
                temp = ""
                continue                
        if oil.index(data) == len(oil)-1:
            sheet1.write(row,headers.index(header),(data+"\n"+temp).strip())
            temp = ""
            continue            
        temp += data
    row += 1

book.save("EdensGarden.xls")