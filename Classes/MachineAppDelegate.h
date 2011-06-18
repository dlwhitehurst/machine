/*********************************************************************
 File: PunchAppDelegate.h
 
 Abstract: This class represents the Application delegate. 
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class RootViewController;
@class ContextController;

@interface MachineAppDelegate : NSObject <UIApplicationDelegate> {
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) NSString *contextKey;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet ContextController *contextController;
@property (nonatomic, retain) IBOutlet UIViewController *detailViewController;
@property (nonatomic, retain) UIPopoverController *popoverController;


@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (NSFetchedResultsController *) fetchedResultsController :withKey:(NSString *)key :sortBy:(NSString *)sortAttr;
- (NSURL *)applicationDocumentsDirectory;
- (void)refreshDisplay;


@end
