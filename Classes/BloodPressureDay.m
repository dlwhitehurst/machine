/*********************************************************************
 File: BloodPressureDay.m
 
 Abstract: This module represents the root object or parent to hold
 one-to-many blood pressure objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "BloodPressureDay.h"
#import "Vital.h"

@implementation BloodPressureDay 

@dynamic blood_pressure_date;
@dynamic children;
@dynamic parent;

@end
