/*********************************************************************
 File: Medicine.m
 
 Abstract: This module represents the root object or parent to hold
 one-to-many prescription objects.  This object is uniquely identified
 by the date or day.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/
#import "Medicine.h"

#import "RxItem.h"

@implementation Medicine 

@dynamic title;
@dynamic medicine_date;
@dynamic subtitle;
@dynamic children;

@end
