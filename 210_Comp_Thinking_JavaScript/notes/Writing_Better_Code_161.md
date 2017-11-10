# Writing Better Code

## Douglas Crockford Talks on JavaScript
[Talk #1](https://youtu.be/RO1Wnu-xKoY?t=38m47s)
[Talk #2](https://www.youtube.com/watch?v=hQVTIJBZook)

## JavaScript Style Guide
[AirBnb Style Guide](https://github.com/airbnb/javascript)

## Errors
### Terminology
JavaScript *throws* an Error. Other languages use *exceptions* to describe errors. Others says *raising* an exception.

### ReferenceError
When a variable or function is referenced that does not exist.
```javascript
a;          // referencing a variable that does not exist
a();        // calling a function that does not exist
```

### TypeError
* When you try to access a property on a value that does not have any properties, like `null`.

```javascript
var a;
typeof(a);


a = 1;
```

### SyntaxError
Handled differently than other errors and usually occurs immediately after loading a JavaScript program, before it begins to run. `SyntaxError`s are detected solely from the program text, unlike `ReferenceError` and `TypeError`.
```javascript
function ( {}     // SyntaxError: Unexpected token (
```

```javascript
```

There are many problems that will raise a `SyntaxError`.

### Other Errors
`RangeError`, `URIError`, and others exist but are more rare.

## Preventing Errors
Best way to handle errors is to prevent them:
```javascript
function lowerInitial(word) {
  return word[0].toLowerCase();
}
```
If passed an empty String
```javascript
```

**Error usually occur where assumptions are made**
**Errors halt execution of the program entirely** and should be avoided as much as possible.

### Guard Clause
*Guard clause* - code that guarantees data meets certain preconditions before it gets used.
```javascript
function lowerInitial(word) {
  if (word.length === 0) {
  }

  return word[0].toLowerCase();
}
```

### When to Use Guard Clauses
* arguments with incorrect types, structures, values, or properties

Your program should be able to trust itself, but not necessarily users.

### Detecting Edge Cases
Think about if your code can violate your assumptions. What would happen? These are considered *edge cases* and often involve values at the extremes of a range.


For a numeric argument, what happens if it is negative or zero? A fractional component when expecting an integer?

also think about how combinations of values can create unexpected conditions.

### Planning Your Code
* Write out the common use cases of a new Function, and chck how your Function handles them.

```javascript


```
Some edge cases
```javascript
```

There can be many many edge cases. Instead, focus on the "happy path" then check the edge cases. If an edge case fails, address it and recheck all the use cases.

## Catching Errors
```javascript
try {
  // Do something that might fail here and throw an Error.
} catch (error) {
  // This code only runs if something in the try clause throws an Error.
  // "error" contains the Error object.
} finally {
  // this code always runs, no matter if the above code throws an Error or not.
}
```
`finally` is optional.

EXAMPLE:
```javascript
function parseJSON(data) {
  var result;

  try {
    result = JSON.parse(data);  // Throws an Error if "data" is invalid
  } catch (e) {
    // We run this code if JSON.parse throws an Error
    // "e" contains an Error object that we can inspect and use.
    result = null;
  } finally {
    // This code runs whether `JSON.parse` succeeds or fails.
  }

  return result;
}


parseJSON(data);        // Logs "there was a SyntaxError parsing JSON data:
                        //       Unexpected token i in JSON at position 0"
                        // Logs "Finished parsing data."
                        // Returns null
```

### When to Use Try/Catch
Only use `try/catch/finally` blocks when the following conditions are both true:
* A built-in JavaScript Function or method can throw an Error and you need to handle or prevent that Error.
* A simple guard clause is impossible or impractical to prevent the Error.