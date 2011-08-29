//
// Vital.h
// 
// Created by David L. Whitehurst on 03/13/2011.
// Modified 08/28/2011
// Copyright 2011. All rights reserved.
//
// This software and associated documentation is PROPRIETARY and 
// PERMISSION TO USE "THE SOFTWARE" IS NOT allowed. In the event  
// "THE SOFTWARE" becomes available to you without written consent
// or transfer of its ownership it must be destroyed and cannot be
// used without the explicit permission of the copyright holder
// listed in the copyright notice in the top of this header.
//
// THE ABOVE COPYRIGHT AND PROPRIETARY NOTICE SHALL BE INCLUDED IN 
// ALL COPIES OR SUBSTANTIAL PORTIONS OF "THE SOFWARE".
//
//

#import <CoreData/CoreData.h>

@class Weight;

@interface Vital :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSDate * vital_date;
@property (nonatomic, retain) NSSet* bg_day_children;
@property (nonatomic, retain) NSSet* weight_children;
@property (nonatomic, retain) NSSet* bp_day_children;

@end


@interface Vital (CoreDataGeneratedAccessors)
- (void)addBg_day_childrenObject:(NSManagedObject *)value;
- (void)removeBg_day_childrenObject:(NSManagedObject *)value;
- (void)addBg_day_children:(NSSet *)value;
- (void)removeBg_day_children:(NSSet *)value;

- (void)addWeight_childrenObject:(Weight *)value;
- (void)removeWeight_childrenObject:(Weight *)value;
- (void)addWeight_children:(NSSet *)value;
- (void)removeWeight_children:(NSSet *)value;

- (void)addBp_day_childrenObject:(NSManagedObject *)value;
- (void)removeBp_day_childrenObject:(NSManagedObject *)value;
- (void)addBp_day_children:(NSSet *)value;
- (void)removeBp_day_children:(NSSet *)value;

@end

