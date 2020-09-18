# Selene

Selene is a project template to quickly set up LOVE2D to run moonscript instead of Lua.

MoonScript is much nicer than Lua and leafo has fixed a lot of things about Lua in making the language. 

# Installing

Note: for the time being I can only gurantee this works on NixOS unstable. Will likely also be fine on other linuxes.

Just clone this repo:

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

The template also includes some recommended setups but they don't *have* to be used. Just my personal preferences.


# Using

Write all your code in `src/main.moon` and other files, just be sure to `require` what you need from `main.moon`!

Yep, that's really it. Just do `love .` in the current directory or `love selene` from outside it.

# Notes

You'll notice that the embedded submodule is not moonscript master. Instead it is my own fork. All I have done is replace the C dependency `lpeg` with a drop-in replacement written in Lua, `lulpeg`. I'll update my moonscript repo from upstream periodically, but it isn't guaranteed to be constant.
