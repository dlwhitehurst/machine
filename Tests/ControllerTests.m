//
//  SetupTests.m
//  Machine
//
//  Created by David Whitehurst on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <GHUnitIOS/GHUnit.h>
#import <CoreData/CoreData.h>
#import "Goal.h"
#import "GoalRec.h"

@interface ControllerTests : GHTestCase { }
@property (retain) Goal *goal;
@end

@implementation ControllerTests
@synthesize goal;

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
    self.goal = [[[Goal alloc] init] autorelease];
}

- (void)tearDown {
    // Run after each test method
    self.goal = nil;   // prevents memory leak
}  

- (void)testImageArray {

    NSString *str = @"Hello";
    Goal *obj = self.goal;
    obj.goal = str;
    GHAssertEqualStrings(obj.goal, @"Hello", nil);
    
}

@end