/*********************************************************************
 File: Medicine.h
 
 Abstract: This header represents the root object or parent to hold
 one-to-many prescription objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class RxItem;

@interface Medicine :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * medicine_date;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSSet* children;

@end


@interface Medicine (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(RxItem *)value;
- (void)removeChildrenObject:(RxItem *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

@end

