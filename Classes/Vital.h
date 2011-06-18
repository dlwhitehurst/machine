/*********************************************************************
 File: Vital.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many health monitoring objects (blood glucose, pressure, weight).  
 This object is uniquely identified by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class Weight;

@interface Vital :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSDate * vital_date;
@property (nonatomic, retain) NSSet* bg_day_children;
@property (nonatomic, retain) NSSet* weight_children;
@property (nonatomic, retain) NSSet* bp_day_children;

@end


@interface Vital (CoreDataGeneratedAccessors)
- (void)addBg_day_childrenObject:(NSManagedObject *)value;
- (void)removeBg_day_childrenObject:(NSManagedObject *)value;
- (void)addBg_day_children:(NSSet *)value;
- (void)removeBg_day_children:(NSSet *)value;

- (void)addWeight_childrenObject:(Weight *)value;
- (void)removeWeight_childrenObject:(Weight *)value;
- (void)addWeight_children:(NSSet *)value;
- (void)removeWeight_children:(NSSet *)value;

- (void)addBp_day_childrenObject:(NSManagedObject *)value;
- (void)removeBp_day_childrenObject:(NSManagedObject *)value;
- (void)addBp_day_children:(NSSet *)value;
- (void)removeBp_day_children:(NSSet *)value;

@end

