package Blog::Controller::comments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::comments - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Blog::Controller::comments in comments.');
}



=head2 base
Can place common logic to start chained dispatch here
=cut
sub base :Chained('/') :PathPart('comments') :CaptureArgs(0) {
    my ($self, $c) = @_;
 
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::comment'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 form_create
Display form to collect information for book to create
=cut

sub form_create :Chained('base') :PathPart('create') :Args(1) {
    my ($self, $c,$postid) = @_;
    $c->stash(postid => $postid); 
    # Set the TT template to use
    $c->stash(template => 'comments/form.tt');
}


=head2 form_create_do
 
Take information from form and add to database
 
=cut
 
sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $tname     = $c->request->params->{body}     || 'N/A';
     my $post_id     = $c->request->params->{postid}     || 'N/A';
    $c->stash(postid => $post_id); 
    # Create the book
    my $user = $c->model('DB::comment')->create({
            
            body   => $tname,
            post_id  => $post_id,
            user_id  => $c->session->{__user}{id},
               
        });
    # Handle relationship with author
    #$book->add_to_book_authors({author_id => $author_id});
    # Note: Above is a shortcut for this:
    # $book->create_related('book_authors', {author_id => $author_id});
 
    # Store new model object in stash and set template
    $c->stash(user     => $user,
              template => 'comments/create_done.tt');
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
