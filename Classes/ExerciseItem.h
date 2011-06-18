/*********************************************************************
 File: ExerciseItem.h
 
 Abstract: This header represents the exercise item object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class Exercise;

@interface ExerciseItem :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * aerobic;
@property (nonatomic, retain) NSNumber * reps;
@property (nonatomic, retain) NSString * exercise;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) Exercise * parent;

@end



