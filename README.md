# About js-modules

This project provides an "extendClass" function that will allow you to split your JavaScript
"classes" in multiple files for better organization. This is specially useful for splitting tests.

See [_spec/modules\_spec.coffee_](js-modules/blob/master/spec/modules_spec.coffee) for example usage.

# Usage with plain JavaScript

I don't write JavaScript anymore, but if you do, you can compile the source to JavaScript and have
fun. If you don't have NPM or CoffeeScript installed, you can just copy and paste in
"Try CoffeeScript" tab of the [CoffeeScript web site](http://coffeescript.org).

Use this same technique for the specs as well if you want to see the examples in JavaScript, although you won't appreciate the _binding_ examples very much. :)

# Running the specs

I run the specs with:

    sudo npm install jasmine-node -g
    jasmine-node --coffee spec

If you remove the first line of the spec and include the modules.js in your Jasmine browser test
runner I guess you could run the spec suite in the browser as well.

Actually I only used Node.js for testing because it was simpler, but I usually use this helper
function for browser client-side programming.
