package Blog::Controller::Users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Blog::Controller::Users in Users.');
}



=encoding utf8

=head1 AUTHOR

merit,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

=head2 list
Fetch all users and pass to the view in
stash to be displayed
=cut

sub hello :local {
    my ( $self, $c ) = @_;
 
    $c->stash(template => 'hello.tt');
}

#sub list :Local {
#my ($self, $c) = @_;
#$c->stash(users => '');
#$c->stash(template => 'users/list.tt');
#}

