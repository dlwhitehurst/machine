/*********************************************************************
 File: BloodPressureDay.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many blood pressure objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class Vital;

@interface BloodPressureDay :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * blood_pressure_date;
@property (nonatomic, retain) NSSet* children;
@property (nonatomic, retain) Vital * parent;

@end


@interface BloodPressureDay (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(NSManagedObject *)value;
- (void)removeChildrenObject:(NSManagedObject *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

