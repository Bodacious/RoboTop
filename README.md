# 🤖🤖 RoboTop 🤖🤖

A table-top Robot game

## Installation

Install on your local machine with the following command:

```
git clone git@github.com:Bodacious/RoboTop.git
```

Next, ensure you have the required gems installed with the following command:

```
bundle install
```

## How to play

### Playing live

From the root directory of the application, run the following command to start the game:

``` bash
bin/robo_top
```

This will start a new session with your robot. Your robot will respond to the following typed commands:

- "MOVE"
- "LEFT"
- "RIGHT"
- "REPORT"
- "PLACE x,y,f"*

_* (where x and y are numbers < 5, and f is one of NORTH,EAST,SOUTH,WEST)_

Press the Enter or Return key to execute each typed command one by one.

### Playing with a pre-written sequence

You may also provide a text file with a list of instructions. This file should contain one instruction per line, with no additional spaces, comments, or other text.

``` bash
bin/robo_top --file spec/training/routine_3.txt
```

This will start a new session with your robot, and execute the sequence of commands before terminating.

### Playing with debugging feedback

Both while playing live or with a pre-written sequence, you can choose to log the result of each command to the logger file found at `./log/output.log`. To use logging, pass the option `--debug` when running the `bin/robo_top` command. For example:

```
bin/robo_top --debug
bin/robo_top -d --file spec/training/routine_1.txt
```

## Tests

To run the test suite, first ensure that you have the necessary gems installed, and then run `rspec spec`

```
bundle install --with=test
rspec spec
```

## Documentation

The code is well documented using the TomDoc format.

More human-friendly documentation is available if required. To generate this, make sure the required gems are installed, and then execute the `yard doc` command:

```
bundle install --with=docs
yard doc --plugin tomdoc --hide-void-return --title "RoboTop" --markup=markdown --markup-provider=kramdown --readme=README.md
```

This will build HTML files at `./doc/` which you can view in your browser.
