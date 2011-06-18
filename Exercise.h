/*********************************************************************
 File: Exercise.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many exercise item objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>


@interface Exercise :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * exercise_date;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSSet* children;

@end


@interface Exercise (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(NSManagedObject *)value;
- (void)removeChildrenObject:(NSManagedObject *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

