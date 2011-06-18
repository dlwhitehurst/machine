/*********************************************************************
 File: BloodPressure.h
 
 Abstract: This header represents the blood pressure object.  
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <CoreData/CoreData.h>

@class BloodPressureDay;

@interface BloodPressure :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSDate * taken_date;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) BloodPressureDay * parent;

@end


