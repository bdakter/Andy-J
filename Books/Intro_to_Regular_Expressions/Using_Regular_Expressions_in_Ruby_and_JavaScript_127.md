# Using Regular Expressions in Ruby and JavaScript

Oddly, the methods used will mostly come from the `String` class, not the `Regexp` class (Ruby) or and `RegExp` class (JavaScript).

## Matching Strings
At the most basic, `match` gives a truthy value that can be used in conditionals.
#### Ruby
```ruby
fetch_url(text) if text.match(/\\Ahttps?:\\/\\/\\S+\\z/)
```

#### JavaScript
```javascript
if (text.match(/^https?:\\/\\/\\S+$/)) {
  fetch_url(text);
}
```

This code will call `fetch_url(text)` only if `match` returns a value that indicates a match - meaning `text` looks like a URL. If a regex fails to match a string, the return value will be `nil` in Ruby, `null` in JavaScript. In Ruby, the return value of `match` is _not_ an Array, but a `MatchData` object. * Most Array methods will not apply directly to this object.

Often rubyist will write the above expression like so... to accomplish the same task.
```ruby
fetch_url(text) if text =~ /\\Ahttps?:\\/\\/\\S+\\z/
```
`=~` and `match` are similar except `=~` will return the index within the string at which the regex matched, or `nil` if there was no match. This is measurably faster than `match`. Also look at `String#scan`, a global form of `match` that returns an Array of all matching substrings.

## Splitting Strings
`split` is often used for delineation of file data. Simple forms are to delineate at every comma `record.split(",")` or at every new line `record.split("\\n")`. they get more complicated. What about at every arbitrary number of white space characters? Easy! `record.split(/\\s+/)

## Capturing Groups: A Diversion
Capturing groups capture information from the matched string that can later be reused within the same regex, or used to construct new strings based on the matched string.

Example: if you want to match quoted text, you might do the following.
```ruby
```
But this will also match a single quote start to a double quote end and vice versa. So we need a way to capture the first quote and reuse it for the second quote. Here is the solution suign capture grouping.
```ruby
```
The parentheses capture the match the whatever is inside of it, then the `\\1` _backreference_ will reference the first capturing group in the regex. If multiple capturing goups are used, number 2 through 9 #may also be used.
Capturing groups are most useful in methods that transform their strings into new string using regex.

## Transformations in Ruby
This involves matching the string against the regex, and using the results to construct a new string. This part is done with `sub` and `gsub` `sub` transforms the first part of the string that matches while `gsub` transforms every part that matches.

Transform all vowels by replacing them with an empty string.
```ruby
```
Using capturing groups we can do something like this to replace a book title.
```ruby
text = %2(We read "War of the Worlds.")
```

If double quotes are used in the replacement string then you need to double up on the backslashes to escape them.
```ruby
```

When possible, try using single quotes to avoid "leaning toothpick syndrome".

## Transformations in JavaScript
`replace` is usually used. `replace` transforms the part of the string that matches a given regex. Use the `g` option to apply it to every match (instead of only the first match).

```javascript
```

Example with backreferences:
```javascript
// outputs: We read "The Time Machine".
```

## Exercises

1. Write a method that returns true if its argument looks like a URL, false if it does not.
    ```ruby
    def url?(string)
      !!string.match(/\\Ahttps?:\\/\\/\\S+\\z/
    end
    ```
2. Write a method that returns all of the fields in a haphazardly formatted string. The fields are separated by a variety of spaces, tabs, and commas, with possibly multiple occurrences of these characters.
    ```ruby
    def fields(text)
      text.split(/[ \\t,]+/)
    ```
    ```ruby
    def mystery_math(expression)
    ```
    ```ruby
    def mystery_math(expression)
    ```
5. Write a method that changes the first occurrence of the word `apple`, `blueberry`, or `cherry` in a string to `danish`.
    ```ruby
    def danish(text)
    end
    ```
6. Challenge: write a method that changes dates in the format `2016-06-17` to the format `17.06.2016`. You must use a regular expression and should only use methods described in this section.
    ```ruby
    def format_date(date)
    end
    ```
7. Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. You must use a regular expression and should only use methods described in this section.
    ```ruby
    def format_date(date)
    end
    ```