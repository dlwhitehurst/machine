/*********************************************************************
 File: BloodGlucoseDay.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many blood glucose objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

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

