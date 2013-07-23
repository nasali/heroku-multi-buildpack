heroku-multi-buildpack
======================
A Heroku buildpack that supports multiple buildpacks written in Ruby scripts. It uses the release output of all buildpacks it is configured to build and handles environment variables while processing buildpacks.

Usage
-----
Add a trigger text file named .buildpacks to the root of your project. Each line should point to the git repo of a buildpack, with an optional #branch to be used.
Then, create an app on Heroku like so:

```
$ cat .buildpacks
https://github.com/nasali/freetds-buildpack.git
https://github.com/heroku/heroku-buildpack-ruby.git#v64
$ heroku create crazy --buildpack https://github.com/AnyPresence/heroku-multi-buildpack.git
Creating crazy... done, stack is cedar
BUILDPACK_URL=https://github.com/AnyPresence/heroku-multi-buildpack.git
http://crazy.herokuapp.com/ | git@heroku.com:crazy.git
Git remote heroku added
$ git push heroku master
...
```
