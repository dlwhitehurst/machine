/*********************************************************************
 File: Vital.m
 
 Abstract: This module represents the root object or parent to hold
 one-to-many health monitoring objects (blood glucose, pressure, weight).  
 This object is uniquely identified by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "Vital.h"

#import "Weight.h"

@implementation Vital 

@dynamic title;
@dynamic subtitle;
@dynamic vital_date;
@dynamic bg_day_children;
@dynamic weight_children;
@dynamic bp_day_children;

@end
