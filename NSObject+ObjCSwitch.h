//
//  NSObject+ObjCSwitch.h
//  SandBox
//
//  Created by Olivier FR on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

/*
 * Example call:
 *
 * [aString switchCase:
 *  @"string 1", ^{
 *    NSLog(@"aString is equal to string 1!");
 *  },
 *  @"string 2", ^{
 *    NSLog(@"aString is equal to string 2!");
 *  },
 *  @"", ^{
 *    NSLog(@"aString is the empty string!");
 *  },
 *  nil];
 */

@interface NSObject (ObjCSwitch)
-(BOOL)switchCaseWithComparisonSelector:(SEL)selector, ... NS_REQUIRES_NIL_TERMINATION;
-(BOOL)switchCase:(id)firstTestValue, ... NS_REQUIRES_NIL_TERMINATION;
@end
