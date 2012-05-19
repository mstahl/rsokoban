# rsokoban

Really simple Sokoban implementation in Ruby. I wrote it because I'd never written one and 'cause it's a neat game. Don't judge.

## How to play

       #####
       #   #
       # $$####
       #  $ $ #
       #  #   #
    ####  ##$ ######
    #   @ ##     ..#
    ##           ..#
     ########### .+#
              ######

Legend:

  * `@` - The player (you)
  * `#` - Wall
  * `$` - Box
  * `.` - Goal
  * `+` - Box on a goal square

The following keys work in RSokoban:

  * `q` - Quit RSokoban
  * `r` - Reset level
  * `WSAD`/arrow keys - Move
  * 'z' - Undo (unlimited)

## Changelog

### 1.0.1

Fixed broken undo function (it didn't move boxes back to where they were before being pushed).

### 1.0.0

First version. Don't judge.

## Contributing to rsokoban
 
  * Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
  * Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
  * Fork the project.
  * Start a feature/bugfix branch.
  * Commit and push until you are happy with your contribution.
  * Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Max Thom Stahl. See LICENSE.txt for
further details.

