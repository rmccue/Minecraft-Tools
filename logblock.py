from BeautifulSoup import BeautifulSoup
import re
import urllib2

response = urllib2.urlopen('http://diddiz.insane-architects.net/logblock.php')
soup = BeautifulSoup(response.read())
results = soup.findAll('a', href=re.compile('^https?://github.com/downloads'))
print results[0]['href']
