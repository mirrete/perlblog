use utf8;
package Blog::Schema::Result::Post;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Blog::Schema::Result::Post

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<post>

=cut

__PACKAGE__->table("post");

=head1 ACCESSORS

=head2 postid

  data_type: 'integer'
  is_nullable: 0

=head2 body

  data_type: 'varchar'
  is_nullable: 0
  size: 250

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "postid",
  { data_type => "integer", is_nullable => 0 },
  "body",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</postid>

=back

=cut

__PACKAGE__->set_primary_key("postid");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 07:27:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mh4qNksNgGC+M4p0Xas1WA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
