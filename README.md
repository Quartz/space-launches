# space-launches

Converts the [JSR Launch Vehicle database](http://www.planet4589.org/space/lvdb/index.html) into one big CSV file.

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

Convert fixed-width files into one big table:

```
./convert.sh
```

The results will be named ``launches_database.csv``.

## Credits

* [Tim Fernholz](https://qz.com/author/tfernholz/)
* [Christopher Groskopf](https://qz.com/author/chrisqz/)
