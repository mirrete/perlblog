use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Blog';
use Blog::Controller::articles;

ok( request('/articles')->is_success, 'Request should succeed' );
done_testing();
