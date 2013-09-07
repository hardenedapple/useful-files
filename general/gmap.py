"""
Asks google to give directions between 'startpos' and 'endpos'

Can define a position either with urlparse.urlencode(ADDRESS) or with
LAT,LON

Ask googlepaths api for a directions dictionary from
"""
# from IPython.terminal.embed import InteractiveShellEmbed
import json
import urllib.parse as urlparse
import urllib.request as urlreq
import webbrowser

# Define variables (startpos, endpos, method)

# Example: from cambridge train station to selwyn college
selwyn = urlparse.quote_plus('Selwyn College,Grange Road,'\
                             'Cambridge,United Kingdom',
                             safe=',')

train_sta = {'lat': 52.194745, 'lon': 0.137622}
positionstr = '{lat},{lon}'

startpos, endpos = positionstr.format(**train_sta), selwyn
method = 'walking'  # altoptions: 'driving', 'bicycling', 'transit'

# Ask google for directions
pathquery = {'origin': startpos,
             'destination': endpos,
             'mode': method,
             'alternatives': 'false',
             'sensor': 'false'}


gpath_base = 'http://maps.googleapis.com/maps/api/directions/json?{query}'

main_path = gpath_base.format(query=urlparse.urlencode(pathquery))
mydatadict = json.loads(urlreq.urlopen(main_path).read().decode('utf-8'))
# ipshell()
try:
    pathpolyline = mydatadict['routes'][0]['overview_polyline']['points']
except KeyError:
    # probably error in original query
    assert mydatadict['status'] != 'OK', 'google directions status: '\
        '{}'.format(mydatadict['status'])
    raise RuntimeError('Something add happening - don\'t know what')
# Use google directions to ask google for a map
path_str = 'color:{color}|weight:{weight}|enc:{polydat}'

querydict = {'maptype': 'roadmap',
             'markers': 'color:red|label:S|{}'.format(endpos),
             'path': path_str.format(color='blue', weight=4,
                                     polydat=pathpolyline),
             'sensor': 'false',
             'size': '1100x600',
             'visual_refresh': 'true'}


gmap_base = 'http://maps.googleapis.com/maps/api/staticmap?{query}'

main_path = gmap_base.format(query=urlparse.urlencode(querydict))
# Show the map
webbrowser.open(main_path)
