# Selene 🌙

Selene is a project template to quickly set up LOVE2D to run moonscript instead of Lua,
*without* precompiling your `.moon` files to `.lua`

[MoonScript](https://github.com/leafo/moonscript) is extremely well suited to writing
games with its object-oriented approach!

# Table of Contents

- [Selene 🌙](#selene-)
- [Table of Contents](#table-of-contents)
- [Installing](#installing)
  - [Install LOVE2D](#install-love2d)
  - [Create Your Game](#create-your-game)
- [Using](#using)
  - [First Run](#first-run)
  - [Writing Your Game](#writing-your-game)
- [Unit Testing](#unit-testing)
- [Notes](#notes)
- [Useful Documentation](#useful-documentation)
- [Contributions and Bug Fixes](#contributions-and-bug-fixes)
- [Thanks](#thanks)

# Installing

Selene works on Debian, Ubuntu, NixOS, and Windows. It should also work anywhere else that LOVE2D runs!

## Install LOVE2D

Selene needs LOVE2D to be installed to run your game, and you can get the installer for your platform at
[the LOVE2D website](https://love2d.org).

## Create Your Game

You have two options when using Selene to create your game:

First (and most recommended) is to use this
repo as a template repo. To do that, click the button at the top right of the
[github page](https://github.com/novafacing/selene) that says "Use this template". That will create a new
repo in your account that is a copy of the Selene repo!

Second, is you can directly clone and modify this repo (or a fork of it), or just download the zip file of
this repo.

Once you have decided, just clone this repo (replace the link with your own if you forked or used it as a
template):

```sh
$ git clone https://github.com/novafacing/selene.git
```

Then, you will need to tell git to download the submodules for this repo that are needed to run MoonScript
without precompiling:

```sh
$ cd selene                               # Go into the git repository on your local machine
$ git submodule update --init --recursive # Update the git submodules for this repo
```

That's it! The conf.lua and main.lua take care of everything else. 

# Using

## First Run

Now that you have the repository set up, just run `love .` to start your game! There is a demo project
already configured for you, and you should see something like this:

![A screenshot of the game running, displaying a moon image on the default LOVE2D light blue background](https://user-images.githubusercontent.com/30083762/180328998-579a5c85-3e95-4551-9018-b17c68414a76.png)

and you should be able to move around with the arrow keys.

## Writing Your Game

Now that you're all set up, write your game! Your source code should go in [the src directory](src/), and you
can add as many files as you want. [The main file](src/main.moon) gives an example of how to require another
file (in this case `demo.moon`) to make your game's code modular.

# Unit Testing

An example unit test is given in [src/util/TestVector2.moon] that uses `busted` for unit
testing. You will need to install `busted` to run the tests:

```sh
$ luarocks install busted
```

And then you can run them with:

```sh
$ busted src/util/TestVector2.moon
●●●●●
5 successes / 0 failures / 0 errors / 0 pending : 0.007048 seconds
```

# Notes

You'll notice that the embedded submodule is not moonscript master. Instead it is my own fork. 
All I have done is replace the C dependency `lpeg` with a drop-in replacement written in Lua, 
`lulpeg`. I'll update my MoonScript and LuLPeg repos from upstream periodically, and feel free
to file an issue if they breaking due to being outdated.

# Useful Documentation

* [Love2D Documentation](https://love2d.org/wiki/Main_Page)
* [Moonscript Documentation](https://moonscript.org/)

# Contributions and Bug Fixes

Bug fixes and contributions are welcome! If you find any issues, just open an Issue and I'll
take a look at it. I'm not going to formalize the process too much, because this is a tiny repo
and I don't expect I'll add too much code to it. Any improvements are likewise appreciated!

# Thanks

Thanks for using Selene! I hope it helps you create great games, and if you do, please open a PR to
add a gif or screenshot of your game and a link to it to this README so you can show it off!
