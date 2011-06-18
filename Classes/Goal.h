/*********************************************************************
 File: Goal.h
 
 Abstract: This header represents the goal object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class GoalRec;

@interface Goal :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * goal;
@property (nonatomic, retain) NSDate * actual_date;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSDate * target_date;
@property (nonatomic, retain) GoalRec * parent;

@end



