use Mojo::Base -strict;
use Test::More;
use JSON::Validator;

my $spec = Mojo::File::path(qw(t spec person.json))->to_abs;
my $jv   = JSON::Validator->new;

note "file://$spec";
ok eval { $jv->schema("file://$spec") }, 'loaded from file://';
isa_ok($jv->schema, 'Mojo::JSON::Pointer');
is $jv->schema->get('/title'), 'Example Schema', 'got example schema';
{
  local $TODO = "version 7";
  my $schemas = $jv->{schemas};
  is keys(%$schemas), 1, 'only one schema';
}
done_testing;
