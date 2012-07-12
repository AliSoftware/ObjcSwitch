//
//  NSObject+ObjCSwitch.m
//  SandBox
//
//  Created by Olivier FR on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+ObjCSwitch.h"
#import <objc/runtime.h>

@implementation NSObject (ObjCSwitch)

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Method

-(BOOL)switchCaseWithComparisonSelector:(SEL)selector
                firstTestValue:(id)firstTestValue
                otherArguments:(va_list)args;
{
    
    id testValue = firstTestValue;
    dispatch_block_t code;
    
    BOOL (*compareFunction)(id, SEL, id) = (BOOL(*)(id,SEL,id))[self methodForSelector:selector];
    BOOL oneCaseHit = NO;
    
    while (testValue != nil)
    {
        code = va_arg(args, dispatch_block_t);
        
        if (compareFunction(self, selector, testValue))
        {
            oneCaseHit = YES;
            code();
            break;
        }
        
        testValue = va_arg(args, id);
    }
    
    return oneCaseHit;
}



/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

-(BOOL)switchCaseWithComparisonSelector:(SEL)selector, ...
{
    va_list args;
    va_start(args, selector);
    id case1 = va_arg(args, id);
    
    BOOL oneCaseHit = [self switchCaseWithComparisonSelector:selector
                                              firstTestValue:case1
                                              otherArguments:args];
    
    va_end(args);
    
    return oneCaseHit;
}
-(BOOL)switchCase:(id)firstTestValue, ...
{
    va_list args;
    va_start(args, firstTestValue);

    BOOL oneCaseHit = [self switchCaseWithComparisonSelector:@selector(isEqual:)
                                              firstTestValue:firstTestValue
                                              otherArguments:args];
    
    va_end(args);
    
    return oneCaseHit;
}


@end
