#!/usr/bin/python3
import gi
import subprocess
from geopy.geocoders import Nominatim

# Initialize Nominatim API with a descriptive user agent
geolocator = Nominatim(user_agent="my_geopy_app")

gi.require_version("Geoclue", "2.0")
from gi.repository import Geoclue

client = Geoclue.Simple.new_sync("my-app-id", Geoclue.AccuracyLevel.CITY, None)
location = client.get_location()
latitude = location.get_property("latitude")
longitude = location.get_property("longitude")
location = geolocator.reverse((latitude, longitude), exactly_one=True)
address = location.raw["address"]
city = address.get("city", "")
subprocess.run(["wttrbar", "--location", city])
