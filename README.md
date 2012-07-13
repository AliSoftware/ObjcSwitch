ObjcSwitch
==========

This NSObject category allows you to use a "switch/case"-like syntax with any NSObject.

The use of swich/case is not limited to integers/enums anymore!


## Basic Example

    [someString switchCase:
     @"value1", ^{
         NSLog(@"The string someString is equal to value1!");
     },
     @"value2", ^{
         NSLog(@"The string someString is equal to the other value value2!");
     },
     @"", ^{
         NSLog(@"The string someString is empty!");
     }, nil];

## Expected arguments

The `switchCase:` method takes a `nil`-terminated variable number of arguments,
  that needs to go by pairs (like in the `dictionaryWithObjectsAndKeys:` method for example).

The first argument is a value to be tested. The second argument
  is the block of code to be executed if the object
  (on which we called the `switchCase:` method) is equal to the preceding value.
The next arguments continue the same way (test object, code block, test object, code block, ...)
  until the value `nil` is met.

* The arguments with an odd position (first, third, fifth, ...) have to be `id` objects.
* The arguments with an even position (second, fourth, sixth, ...) have to be blocks
    that does not take arguments and does not return a value (a.k.a. blocks of type `dispatch_block_t`),
    which simply means blocks with the syntax `^{ /* some code */ }`.

_Note: Be careful to respect these types: as with every methods having a variable number of arguments
  (like `dictionaryWithObjectsAndKeys:` and others) the parameters are not checked at compile-time.
  So parameters with the wrong type may lead to unexpected behavior or crashes at runtime._


## Implementing the `default:` case

The `switchCase:` method returns `YES` if it has found an object equal to the target object
  (and thus has executed the corresponding code) and `NO` if none of the test objects were found
  equal to the target object.
  
This allows you to implement the equivalent of the "`default:`" statement by testing the return
  value of the `switchCase:` method, for example this (compact) way:
  
    if(![someObject switchCase:
         comparisonObject1, ^{ NSLog(@"Case 1"); },
         comparisonObject2, ^{ NSLog(@"Case 2"); },
         nil])
    { // default: 
        NSLog(@"Default: No case found!");
    }


###### Note
The global behavior of the `switchCase:` method is designed so that it returns as soon as
  an object is found equal to the target object (and its corresponding code is executed),
  without testing the values after the found one.
This is the equivalent (compared to a standard C switch/case statement) of having a `break;` after each `case:`.
It is thus guaranteed than no more than one block of code will be executed by the `switchCase:` method.

## Using a different selector than `isEqual:`

The `switchCase:` method uses the `isEqual:` selector to compare the target object to
  the objects to be tested in the parameters.

An alternative method `switchCaseWithComparisonSelector:` is provided if you need
  to use a selector other than `isEqual:` for objects comparison.
Its syntax is basically the same as `switchCase:`, except that you provide the `@selector`
  to use as the first parameter before the `nil`-terminated list of testObject/codeBlock pairs:
  
    [[name lowercaseString] switchCaseWithComparisonSelector:@selector(isEqualToString:),
     @"firstname",  ^{ NSLog(@"This is FirstName"); },
     @"secondname", ^{ NSLog(@"Hello SecondName"); },
     @"thirdname",  ^{ NSLog(@"I am ThirdName"); },
     nil];

The selector used must take a single parameter of type `id` and return a value of type `BOOL`
  (exactly as the `isEqual:` method and other `isEqualToXXX:` methods like `isEqualToString:`).


# Integrate in your projects

Simply drag & drop the `NSObject+ObjCSwitch.h` and `NSObject+ObjCSwitch.m` files in your Xcode project.

Then, when you want to use the `switchCase:` method on any object, don't forget to import the header
  in your file (or you may instead add the `#import "NSObject+ObjCSwitch.h` in your
  Precompiled Header File (`xxx-Prefix.pch`) to avoid the need to import it everywhere in your source code).


_Note: ObjCSwitch is compatible with both ARC and non-ARC projects (it does not create, retain or release any object anyway)_
