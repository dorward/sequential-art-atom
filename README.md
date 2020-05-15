# SequentialArt Update Seeker

Generates an ATOM feed for Phillip M Jackson's [Sequential
Art](https://www.collectedcurios.com/sequentialart.php) strip.

## Getting Started

Download the repository. Put it somewhere sensible. Install the prerequisites. Then run:

    perl Sequential-Art.pl --db ./db.db --atom_file /hosts/example.com/pages/sequential.atom --atom_url http://example.com/sequential.atom

### Prerequisites

* Perl (Install it via [Perlbrew](https://perlbrew.pl/))
* Perl modules. Install them via: ```cpanm DBIx::Class::Schema LWP::UserAgent LWP::Protocol::https HTML::TreeBuilder HTML::TreeBuilder::XPath XML::Atom::SimpleFeed Getopt::Long```

## Contributing

Pull requests welcome.

## Authors

* **David Dorward** - *Initial work* - [Dorward](https://github.com/dorward)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
