heroku-multi-buildpack
======================
A Heroku buildpack that supports multiple buildpacks written in Ruby scripts. It uses the release output of all buildpacks it is configured to build.

Usage
-----
Add a trigger text file named .buildpacks to the root of your project. Each line should point to the git repo of a buildpack.
Then, create an app on Heroku with something like: 

  heroku create crazy --buildpack https://github.com/nasali/heroku-multi-buildpack.git
  
