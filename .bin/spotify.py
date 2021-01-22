import dbus
from os.path import expanduser


status_file = expanduser('~') + '/.bin/status_spotify'

def write_to_file(output):
    with open(status_file, 'w') as file:
        file.write(output)

def format_output(metadata):
    return metadata['title'] + ' - ' + metadata['artist']

def clean_metadata(metadata):
    temp_dict = {}
    for k, v in metadata.items(): 
        temp_dict[str(k).split(':')[1]] = str(v[0]) if type(v) == dbus.Array else str(v)
    return temp_dict

def get_metadata(): 
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object('org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2')
    spotify_properties = dbus.Interface(spotify_bus, 'org.freedesktop.DBus.Properties')
    return spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

def main():     
    cleaned = clean_metadata(get_metadata())
    output = format_output(cleaned)
    write_to_file(output)

if __name__ == '__main__':
    main() 

