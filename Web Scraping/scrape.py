def uniq(stuff):
    temp = stuff.copy()
    for o in temp:
        if stuff.count(o) > 1:
            stuff.remove(o)
    return stuff

from bs4 import BeautifulSoup
import requests
import time

r1 = requests.get('http://www.edensgarden.com/collections/single-oils?page=1')
soup1 = BeautifulSoup(r1.content, 'html.parser')
r1.close()

r2 = requests.get('http://www.edensgarden.com/collections/single-oils?page=2')
soup2 = BeautifulSoup(r2.content, 'html.parser')
r2.close()

r3 = requests.get('http://www.edensgarden.com/collections/single-oils?page=3')
soup3 = BeautifulSoup(r3.content, 'html.parser')
r3.close

products = []
for soup in [soup1,soup2,soup3]:
    for link in soup.find_all('a'):
        ref = link.get("href")
        if "products" in ref:
            products.append("http://www.edensgarden.com"+ref)
products = uniq(products)

def getDesc(url):
    prod = BeautifulSoup(requests.get(url).content, 'html.parser')
    desc = uniq(prod.find("div","description").text.split("\n"))
    price = prod.find("h2","price").text
    name = prod.find(id="product")['class'][0]
    desc.insert(0,price.strip().title())
    desc.insert(0,name.strip().replace("-"," ").title())
    desc.insert(0,"Name:")
    desc.insert(2,"Price:")
    desc.insert(4,"Description:")

    return desc
    
data = open("edensgarden.txt","w")

for i in range(0,len(products)):
    desc = getDesc(products[i])
    for o in desc:
        data.write(o+"&")
    data.write("\n\n")
    print(i)
    time.sleep(1)

data.close()
    