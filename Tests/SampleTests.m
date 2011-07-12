//
// SampleTests.m
// 
// Created by David L. Whitehurst on 06/18/2011.
// Copyright 2011. All rights reserved.
//
// This software and associated documentation is PROPRIETARY and 
// PERMISSION TO USE "THE SOFTWARE" IS NOT allowed. In the event  
// "THE SOFTWARE" becomes available to you without written consent
// or transfer of its ownership it must be destroyed and cannot be
// used without the explicit permission of the copyright holder
// listed in the copyright notice in the top of this header.
//
// THE ABOVE COPYRIGHT AND PROPRIETARY NOTICE SHALL BE INCLUDED IN 
// ALL COPIES OR SUBSTANTIAL PORTIONS OF "THE SOFWARE".
//
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