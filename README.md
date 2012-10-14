kml-bo
======

Utility for working with kml files including douglas peucker path simplification and export to ruby array.

Examples:
Parse KML file and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml simple.rb

Parse KML file. Simplify the path and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml simple.rb -s

Parse KML file. Simplify the path with a very aggressive epsilon value and output all coordinates to a ruby array in a file called simple.rb

    ./kmlbo sample.kml simple.rb -s 0.0000001
    
Parse KML file. Simplify the path and output a file called simple.kml

    ./kmlbo sample.kml simple.rb -ks