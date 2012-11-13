kmlbo
======

A Gem for converting kml path data to ruby arrays, and applying douglas peucker path simplification.

Features:

1. Simplify a path using the [Douglas Peucker algorithm](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm). 
2. Apply Douglas Peucker multiple times on the same path, allowing you to compress a line arbitrarily.
3. Output as KML or a ruby array.
4. KML files are readable by Google Earth.

##Installation
    gem install kmlbo
    
##Usage Examples
  Parse KML file. Simplify with 5 passes of douglas peucker.

    ./kmlbo sample.kml simple.rb -s 0.000000001 -k -m 5
    Simplified path from 6371 to 397 points

  Parse KML file and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml sample.rb

  Parse KML file. Simplify the path and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml simple.rb -s
    Simplified path from 6371 to 3796 points

  Parse KML file. Simplify the path with a very aggressive epsilon value and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml simple.rb -s 0.0000001
    Simplified path from 6371 to 3134 points

  Parse KML file. Simplify the path and output a file called simple.kml

    ./kmlbo sample.kml simple.kml -k -s
    Simplified path from 6371 to 3796 points