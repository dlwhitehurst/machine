//
// Medicine.h
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

