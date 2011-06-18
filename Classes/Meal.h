/*********************************************************************
 File: Meal.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many food item objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class FoodItem;

@interface Meal :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * meal_date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSSet* children;

@end


@interface Meal (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(FoodItem *)value;
- (void)removeChildrenObject:(FoodItem *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

