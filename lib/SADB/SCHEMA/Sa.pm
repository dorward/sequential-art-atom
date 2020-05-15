package SADB::SCHEMA::Sa;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("sa");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "image",
  {
    data_type => "varchar",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-26 17:44:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MKKlXtAUnPalRXtFdH293w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
