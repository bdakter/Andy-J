# Bundler
A project may need a Ruby version that differs from your default Ruby. Even if you got that right, it might need a different version of a RubyGem. In Ruby, RVM or rbenv are Ruby version managers to help manage this.

The favored approach for managing Gem dependencies is to use a __dependency manager__. The mostly widely used on is Bundler Gem.

> In this chapter, we use the term __app__ or __application__ to refer to any Ruby code that you run or use with Bundler. note that this includes Gems that you develop yourself, as well as full-blown applications.

## Installing Bundler
Bundler is a gem, so if RVM or another Ruby manage is used then Bundler needs to be installed in every version of Ruby you need it in.
```bash
gem install bundler
```

## Gemfile and Gemfile.lock

## Where Are My Rubies, Gems, and Apps Now?
Bundler does not interfere with them. They will remain where they always have been. So you can still use `gem env`, `rvm info`, and `rbenv version` and other info commands to find information you may need.

## bundle exec

This command modifies the environment by changing paths. One important change is `RUBYOPT=-rbundler/setup` which allows Bundler to gain control in time to configure everything.

### When Should You Use `bundle exec`?
You usually use it with commands written in Ruby and installed as Gems, e.g., Rake, Pry, and Rackup. Use it to resolve dependency conflicts when issuing shell commands.
```bash
Gem::LoadError: You have already activated rake 11.3.0, but your Gemfile requires rake 10.4.2. Prepending `bundle exec` to your command may solve this.
```
If you get something like this you make need `bundle exec`.
So the easy solution in this case is to run
```bash
bundle exec rake
```
So use it with dependency discrepancies. "Always use `bundle exec <command>`" is good advice. 

`binstubs`

This is an alternative to using `bundle exec`. It sets up a directory of short Ruby scripts (wrappers) with the same names as executables installed by your Gems. This directory will be called `bin` but override the name if your app also needs a `bin` directory of it own.

## When Things Go Wrong
Most of the time Bundler is used to solve problems, not create them, but it can. Bundler is a Gem and as such will have different versions. 

Some things to try if problems continue:
* Remove your `Gemfile.lock` and run `bundle install` again. This creates a new `Gemfile.lock` file.
* Remove the `.bundle` directory and its contents from your project directory and run `bundle install` again.
* Remove and reinstall Bundler:
  ```bash
  gem uninstall bundler
  gem install bundler
  ```
* If `gem list` shows that either `rubygems-bundler` or `open_gem` are installed, uninstall them. these old Gems are incompatible with bundler. Repeat the above items if you remove either Gem.
  ```bash
  rm Gemfile.lock ; DEBUG_RESOLVER=1 bundle install
  ```
  This removes the `Gemfile.lock` file, then runs `bundle install` while producing debug information. 