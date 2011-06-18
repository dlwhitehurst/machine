/*********************************************************************
 File: GoalRec.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many goal objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class Goal;

@interface GoalRec :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * goal_date;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSSet* children;

@end


@interface GoalRec (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(Goal *)value;
- (void)removeChildrenObject:(Goal *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

