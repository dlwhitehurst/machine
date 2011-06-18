/*********************************************************************
 File: Weight.h
 
 Abstract: This header represents the weight object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>


@interface Weight :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSDate * taken_date;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSManagedObject * parent;

@end



