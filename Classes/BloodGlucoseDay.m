/*********************************************************************
 File: BloodGlucoseDay.m
 
 Abstract: This module represents the root object or parent to hold
 one-to-many blood glucose objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "BloodGlucoseDay.h"

#import "BloodGlucose.h"
#import "Vital.h"

@implementation BloodGlucoseDay 

@dynamic blood_glucose_date;
@dynamic children;
@dynamic parent;

@end
