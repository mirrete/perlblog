package Blog::Controller::users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Blog::Controller::users in users.');
}

=head2 base
Can place common logic to start chained dispatch here
=cut
sub base :Chained('/') :PathPart('users') :CaptureArgs(0) {
    my ($self, $c) = @_;
 
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::user'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 form_create
Display form to collect information for book to create
=cut

sub form_create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;
 
    # Set the TT template to use
    $c->stash(template => 'users/form.tt');
}


=head2 form_create_do
 

+Take information from form and add to database
 
=cut
 
sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $tname     = $c->request->params->{name}     || 'N/A';
    my $pass     = $c->request->params->{mypassword}     || 'N/A';
    
    # Create the book
    my $user = $c->model('DB::user')->create({
            
            name   => $tname,
            mypassword  => $pass,
        });
    # Handle relationship with author
    #$book->add_to_book_authors({author_id => $author_id});
    # Note: Above is a shortcut for this:
    # $book->create_related('book_authors', {author_id => $author_id});
 
    # Store new model object in stash and set template
    $c->stash(user     => $user,
              template => 'users/create_done.tt');
}


=head2 list
Fetch all users and pass to the view in
stash to be displayed
=cut
sub list :Local {
my ($self, $c) = @_;
$c->stash(users => [$c->model('DB::user')->all]);
$c->stash(template => 'users/list.tt');
}




=head2 object
 
Fetch the specified book object based on the book ID and store
it in the stash
 
=cut
 
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    # $id = primary key of book to delete
    my ($self, $c, $id) = @_;
 
    # Find the book object and store it in the stash
      $a=$c ->stash->{resultset}->find($id);
    
     $c->stash(object => $a);
    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "user $id not found!" if !$c->stash->{object};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}


=head2 delete
 
Delete a book
 
=cut
 
sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    # Use the book object saved by 'object' and delete it along
    # with related 'book_author' entries
    $c->stash->{object}->delete;
 
    # Set a status message to be displayed at the top of the view
    $c->stash->{status_msg} = "user deleted.";
 
    # Redirect the user back to the list page.  Note the use
    # of $self->action_for as earlier in this section (BasicCRUD)
    $c->response->redirect($c->uri_for($self->action_for('list')));
}






=head2 form_create
Display form to collect information for book to create

sub edit :Chained('object') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;
     
    # Set the TT template to use
    $c->stash(template => 'users/edit.tt');
}
=cut


=head2 form_create_do
 
Take information from form and add to database
 

 
sub form_edit_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $tname     = $c->request->params->{name}     || 'N/A';
    my $pass     = $c->request->params->{mypassword}     || 'N/A';
    my $id     = $c->request->params->{id}     || 'N/A';
    
    # Create the book
    my $user = $c->model('DB::user')->update({
            
            name   => $tname,
            mypassword  => $pass,
        });
    # Handle relationship with author
    #$book->add_to_book_authors({author_id => $author_id});
    # Note: Above is a shortcut for this:
    # $book->create_related('book_authors', {author_id => $author_id});
 
    # Store new model object in stash and set template
    $c->stash(user     => $user,
              template => 'users/create_done.tt');
}

=cut


sub mbase : Chained('/'): PathPart('users'): CaptureArgs(0) {
my ($self, $c) = @_;
$c->stash(users_rs => $c->model('DB::user'));
}

sub muser : Chained('mbase'): PathPart(''): CaptureArgs(1) {
my ($self, $c, $userid) = @_;
my $user = $c->stash->{users_rs}->find({ id => $userid },
{ key => 'primary' });
die "No such user" if(!$user);
$c->stash(user => $user);
}


#sub myedit :Chained('muser') :PathPart('myedit') :Args(0) {
#    my ($self, $c) = @_;
     
    # Set the TT template to use
#    $c->stash(template => 'users/edit.tt');
#}

sub edit : Chained('muser') :PathPart('edit'): Args(0) {

my ($self, $c) = @_;

if(lc $c->req->method eq 'post') {
my $params = $c->req->params;
my $user= $c->stash->{user};
## Update user's email and/or password
$user->update({
name => $params->{name},
mypassword => $params->{mypassword},
});


## Send the user back to the changed profile
$c->res->redirect( $c->uri_for(
$c->controller('users')->action_for('list')
) );

}
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

