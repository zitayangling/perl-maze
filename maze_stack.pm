use strict;
package maze_stack;
# use warnings;
sub new {
	my ($class, $max_size) = @_;
	my @array = ();
	$#array = $max_size;
	$class = ref $class if ref $class;
	my $self = {
		current_size  => 0,
		max_size => $max_size,
		array => @array,
	};
	bless($self, $class);
	return $self;
}
sub size {
	my $self = shift;
	my $num = $$self{"current_size"};
	if($num < 0)
	{
		return 0;
	}
	return $num;
}
sub push {
	my ($self,$data1,$data2,$data3) = @_;
	my $index = $$self{"current_size"};
	if($index >= $$self{"max_size"})
	{
		&full;
	}
	my @array = ();
	push(@array,$data1);
	push(@array,$data2);
	push(@array,$data3);
	for(my $i = 0;$i<3;$i++)
	{
		$$self{"array"}[$index][$i] = $array[$i];
	}	
	$self->{current_size} = $index + 1;
	return @array;
}
sub pop {
	my $self = shift;
	my $index = $self->{current_size};
	if ($index < 0) 
	{
		&empty;
	}
	my @array = ();
	for(my $i = 0;$i<3;$i++)
	{
		$array[$i] = $self->{array}[$index-1][$i];
	}
	$self->{current_size} = $index - 1;
	return @array;
}
sub empty 
{
	die "this stack is empty!\n";
}
sub full {
	die "this stack is full!\n";				
}
sub top{
 	my $self = shift;
 	my $index = $$self{"current_size"};
 	if ($index <= 0) {
 		return "undef";
 	}
 	my @data = ();
 	for (my $i = 0;$i<3;$i++) {
 		$data[$i] = $$self{"array"}[$index-1][$i];
 	}
 	return @data;
}
1;