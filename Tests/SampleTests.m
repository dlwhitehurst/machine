//
//  SampleTests.m
//  Machine
//
//  Created by David Whitehurst on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

@interface SampleTests : GHTestCase { }
@end

@implementation SampleTests

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
}

- (void)tearDown {
    // Run after each test method
}  

- (void)testStrings {
    
    NSString *oneStr = @"Hello";
    NSString *twoStr = @"Hello";

    GHAssertEqualStrings(oneStr, twoStr, nil);
    
}

@end