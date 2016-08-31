use maze;
use maze_stack;
use strict;

my $maze = maze ->new;
$maze->set_start(1,1);
$maze->set_exit(9,6);
$maze ->move;
