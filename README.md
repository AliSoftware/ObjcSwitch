ObjcSwitch
==========

A category to allow you to use the "switch/case"-like syntax to NSObjects!

The idea is to extend the "switch/case" instruction to NSObject (instead of
  having to do a lot of `if/else/else/...` that needs to call `isEqual:`)

## Basic Example

    [someString switchCase:
     @"value1", ^{
         NSLog(@"The string someString is equal to value1!");
     },
     @"value1", ^{
         NSLog(@"The string someString is equal to value1!");
     },
     @"", ^{
         NSLog(@"The string someString is empty!");
     }, nil];

## Arguments

The `switchCase:` method takes a `nil`-terminated variable number of arguments,
  that needs to go by pairs (like in the `dictionaryWithObjectsAndKeys:` method).
   
The first argument is a value to be tested, and the second argument
  is the block of code to be executed if the object
  (on which we called the `switchCase:` method) is equal to the preceding value.
The next arguments continue the same way until `nil` is met.

* The arguments with an odd position (first, third, fifth, ...) have to be `id` objects.
* The arguments with an even position (second, fourth, sixth, ...) have to be blocks
    that does not take arguments and does not return a value (`dispatch_block_t`),
    that is blocks with the syntax `^{ /* some code */ }`.

## Behavior

The first object that returns `YES` when compared to the target object using `isEqual:`
  makes its corresponding block to be executed and the `switchCase:` method to return `YES`.

If no object in the parameters list are found to be equal to the target object,
  the `switchCase:` method returns `NO`.

This means that:

* If multiple objects listed in the parameters are equal to the target object,
  only the first one will trigger its corresponding code. _This is quite the equivalent of
  having a "break" statement after each "case" entry in a standard "switch" C statement._
* You can implement the equivalent of the "default:" statement by testing the return
  value of the `switchCase:` method:
  
    if(![someObject switchCase:
         comparisonObject1, ^{
             NSLog(@"Case 1");
         },
         comparisonObject2, ^{
             NSLog(@"Case 2");
         }, nil])
    { // default: 
        NSLog(@"No case found!");
    }


## Using a different selector than `isEqual:`

The `switchCase:` method uses the `isEqual:` selector to compare the target object to
  the objects to be tested in the parameters.

An alternative method `switchCaseWithComparisonSelector:` is provided if you need
  to selector different to `isEqual:` for objects comparison.
  
Its syntax is basically the same as `switchCase:`, except that you provide the `@selector`
  to use as the first parameter before the `nil`-terminated list of testObject/codeBlock pairs:
  
    [[name lowercaseString] switchCaseWithComparisonSelector:@selector(isEqualToString:),
     @"firstname", ^{ NSLog(@"This is FirstName"); },
     @"secondname", ^{ NSLog(@"Hello SecondName"); },
     @"thirdname", ^{ NSLog(@"I am ThirdName"); },
     nil];
