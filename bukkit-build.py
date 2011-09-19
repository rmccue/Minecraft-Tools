from BeautifulSoup import BeautifulSoup
import urllib2
import re

stuff = urllib2.urlopen('http://ci.bukkit.org/job/dev-CraftBukkit/lastSuccessfulBuild/')
stuff = BeautifulSoup(stuff.read())

matches = re.search('Build #(\d+)', stuff.h1.contents[1])
print matches.group(1)
