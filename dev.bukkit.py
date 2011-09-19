from BeautifulSoup import BeautifulSoup
import re
import urllib2
import sys

project = sys.argv[1]
response = urllib2.urlopen('http://dev.bukkit.org/server-mods/%s/files/' % (project,))
soup = BeautifulSoup(response.read())
result = soup.find('td', attrs = {'class': 'col-file'})
url = 'http://dev.bukkit.org' + result.a['href']
response = urllib2.urlopen(url)
soup = BeautifulSoup(response.read())
result = soup.find('a', href=re.compile('^http://dev.bukkit.org/media/files'))
print result['href']
