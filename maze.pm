use maze_stack;
use strict;
package maze;
my $m = 9;
my $n = 6;
my $stack = maze_stack ->new(($m+2)*($n+2));
my $found = 0;
my @maze = (#迷宫数组
		[2,2,2,2,2,2,2,2],
		[2,0,0,0,0,0,1,2],
		[2,1,0,1,1,1,1,2],
		[2,1,0,0,0,0,1,2],
		[2,0,1,1,1,1,1,2],
		[2,1,0,0,0,0,1,2],
		[2,1,1,1,1,1,0,2],
		[2,1,0,0,0,0,1,2],
		[2,0,1,1,1,1,1,2],
		[2,1,0,0,0,0,0,2],
		[2,2,2,2,2,2,2,2],
		);
	my @mark = ();#标记路径数组
	for (my $i = 0; $i < 8; $i++) {
		for (my $j = 0; $j < 11; $j++) {
			$mark[$j][$i]=0;
		}
	}
	my @move = (#移动数组
		[-1,0],
		[-1,1],
		[0,1],
		[1,1],
		[1,0],
		[1,-1],
		[0,-1],
		[-1,-1],
		);
sub new {
	my $class = shift;
	my $self = {
		row =>0,
		col =>0,
		dir =>0,
		exit_row =>0,
		exit_col =>0,
	};
	bless($self,$class);
	return $self;
}
sub set_exit {
	my ($self,$exit_row,$exit_col) = @_;
	$self->{exit_row} = $exit_row;
	$self->{exit_col} = $exit_col;
}
sub set_start {
	my ($self,$start_row,$start_col) = @_;
	$self->{row} = $start_row;
	$self->{col} = $start_col;
}
sub save_path {
	my ($self,$data1,$data2,$data3) = @_;
	$stack ->push($data1,$data2,$data3);
}
sub top {
	$stack ->top;
}
sub move 
{
	my $self = shift;
	my $top = $stack->{current_size};
	$mark[$self->{row}][$self->{col}] = 1;
	$self->save_path($self->{row},$self->{col},0);
	while ($top > -1 && $found == 0) 
	{
		my @array = $stack->pop;
		$self ->{row} = $array[0];
		$self ->{col} = $array[1];
		$self ->{dir} = $array[2];
		while ($self->{dir} < 8 && $found == 0) 
		{
			my $dir = $self ->{dir};
			my $next_row = $self->{row} + $move[$dir][0];
			my $next_col = $self->{col} + $move[$dir][1];
			if ($self->{row} == $self->{exit_row} && $self->{col} == $self->{exit_col}) 
			{
				print "终点到了\n";
				$stack ->push($self->{row},$self->{col},$dir);
				$found = 1; 
			}
			elsif ($maze[$next_row][$next_col] == 0 && $mark[$next_row][$next_col] == 0) 
			{
				$mark[$next_row][$next_col] = 1;
				$stack ->push($self->{row},$self->{col},$dir);
				$self->{row} = $next_row;
				$self->{col} = $next_col;
				$self->{dir} = 0;
			}
			else
			{
				$self->{dir} += 1;
			}
		}
	}
	if($found == 1)
	{
		print "The path is :\n";
		print "row col\n";
		for (my $i = 0; $i < $stack->{current_size}; $i++) 
		{
			printf "%g %g\n",$stack->{array}[$i][0],$stack->{array}[$i][1];	
		}
	}
	else 
	{
		printf "The maze does not have path\n";
	}
}
1;	