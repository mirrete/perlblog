use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Blog';
use Blog::Controller::users;

ok( request('/users')->is_success, 'Request should succeed' );
done_testing();
