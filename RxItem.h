/*********************************************************************
 File: RxItem.h
 
 Abstract: This header represents the prescription object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@interface RxItem :  NSManagedObject {}

@property (nonatomic, retain) NSString * generic_for;
@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) NSString * purpose;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSManagedObject * parent;

@end



