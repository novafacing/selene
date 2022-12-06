# Selene

Selene is a project template to quickly set up LOVE2D to run moonscript instead of Lua,
*without* precompiling your `.moon` files to `.lua`

[MoonScript](https://github.com/leafo/moonscript) is extremely well suited to writing
games with its object-oriented approach!

# Table of Contents

- [Selene](#selene)
- [Table of Contents](#table-of-contents)
- [Installing](#installing)
- [Using](#using)
- [Notes](#notes)
- [Contributions and Bug Fixes](#contributions-and-bug-fixes)
- [Unit Testing](#unit-testing)

# Installing


Note: for the time being I can only guarantee this works on NixOS unstable. Will likely
also be fine on other linuxes.

Just clone this repo (or, you can use it as a [template repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository)):

```sh
$ git clone ssh://git@github.com/novafacing/selene.git
```

Update the submodules:

```sh
$ cd selene
$ git submodule init
$ git submodule update
```

and ensure the love dependency is installed:

1. [love2d](https://love2d.org/)

That's it! The conf.lua and main.lua take care of everything else. 

The template also includes some recommended setups but they don't *have* to be used. Just
my personal preferences.


# Using

Write all your code in `src/main.moon` and other files, just be sure to `require` what
you need from `main.moon`!

Yep, that's really it. Just do `love .` in the current directory or `love selene` from
outside it.

# Notes

You'll notice that the embedded submodule is not moonscript master. Instead it is my own
fork. All I have done is replace the C dependency `lpeg` with a drop-in replacement
written in Lua, `lulpeg`. I'll update my moonscript repo from upstream periodically, but
it isn't guaranteed to be constant. However, MoonScript has not been updated in several
years so the chances of desynchronization are small.

# Contributions and Bug Fixes

Bug fixes and contributions are welcome! If you find any issues, just open an Issue and
I'll take a look at it. I'm not going to formalize the process too much, because this is
a tiny repo and I don't expect I'll add too much code to it. Any improvements are
likewise appreciated!

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