/*********************************************************************
 File: FoodItem.h
 
 Abstract: This header represents the food item object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>


@interface FoodItem :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * meal;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) NSManagedObject * parent;

@end



