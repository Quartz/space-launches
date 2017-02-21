# space-launches

Converts the [JSR Launch Vehicle database](http://www.planet4589.org/space/lvdb/index.html) into a database suitable for analysis.

## Setup

Install csvkit:

```
pip install csvkit
```

Getting the files:

```
wget http://www.planet4589.org/space/lvdb/launches.tar.gz
tar xvfz launches.tar.gz -C launches
```

## Usage

Convert fixed-width files into CSVs:

```
./convert.sh
./convert_lookups.sh
```

The results can be found in the ``results`` folder.

## Credits

* [Tim Fernholz](https://qz.com/author/tfernholz/)
* [Christopher Groskopf](https://qz.com/author/chrisqz/)
