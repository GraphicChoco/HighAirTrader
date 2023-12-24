# HighAirTrader - Add-on for FlightGear
# Copyright (C) 2023 Peter Clifton
# Writen and developed by Peter Clifton and Thomas Clifton
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

var main = func(addon) {
  #logprint(LOG_INFO, "Skeleton addon initialized from path ", addon.basePath);

  var fname = addon.basePath ~ "/" ~ "interface.nas";
  io.load_nasal(fname); # no second arg so same space will default to the file name
  print("Loaded " ~ fname ~ " from " ~ addon.basePath);

  var nasalfiles = {storage:    "nasal/storage.nas",
                    paperwork:  "nasal/paperwork.nas",
                    funcs:      "nasal/funcs.nas",
                    world:      "nasal/world.nas",
                    constants:  "nasal/constants.nas"
                   };

  foreach(var key; keys(nasalfiles)) {
      var fpath= addon.basePath ~ "/" ~ nasalfiles[key];
      io.load_nasal(fpath, key); 
      print("Loaded " ~ fpath ~ " from " ~ addon.basePath);
  };

  # Create $FG_HOME/Export/Addons.org.flightgear.addons.HighAirTrader directory
  # See: https://forum.flightgear.org/viewtopic.php?f=30&t=32882&start=180
  var storageDir = addon.createStorageDir();
  print("Created storate directory: " ~ storageDir);

  # If we call te findAirportsWithinRange function for the first time during 
  # gameplay it will cause a freeze for a few seconds while the game waits
  # for it to return. So we call it here for no reason other than by doing
  # it should run faster when the user calls it for the first time
  findAirportsWithinRange(100);
  var s1 = "Called findAirportsWithinRange function";
  var s2 = "(to reduce time taken when called by user)"; 
  print(s1 ~ " " ~ s2);
}




