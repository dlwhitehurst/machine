/*********************************************************************
 File: RootViewController.h
 
 Abstract: This class represents the root view controller or the 
 application's initial popover controller. 
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContextController.h"

/*
 SubstitutableDetailViewController defines the protocol that detail view controllers 
 must adopt. The protocol specifies methods to hide and show the bar button item 
 controlling the popover.
 */

@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end


@class ContextController;

@interface RootViewController : UITableViewController <UISplitViewControllerDelegate> {}

// UI
@property (nonatomic, assign) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) UIBarButtonItem *rootPopoverButtonItem;
@property (nonatomic, retain) UIPopoverController *popoverController;

// Data
@property (nonatomic, retain) NSArray *arrayData;
@property (nonatomic, retain) NSArray *subArrayData;
@property (nonatomic, retain) NSArray *imagesList;

- (NSArray *) getImageArray;

@end

