//
// BloodGlucoseDay.h
// 
// Created by David L. Whitehurst on 03/13/2011.
// Modified 08/28/2011
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

#import <CoreData/CoreData.h>

@class BloodGlucose;
@class Vital;

@interface BloodGlucoseDay :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * blood_glucose_date;
@property (nonatomic, retain) NSSet* children;
@property (nonatomic, retain) Vital * parent;

@end


@interface BloodGlucoseDay (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(BloodGlucose *)value;
- (void)removeChildrenObject:(BloodGlucose *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

