/*********************************************************************
 File: VitalDetailViewController.h
 
 Abstract: A detail view controller that manages the widgets for the
 VitalDetailView.xib file.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h";


@interface VitalDetailViewController : UIViewController <NSFetchedResultsControllerDelegate, SubstitutableDetailViewController>{
	// UI
    //UIPopoverController *popoverController;
    UIToolbar *toolbar;
	// Data	
	NSManagedObject *detailItem;
	NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// UI
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
//@property (nonatomic, retain) UIPopoverController *popoverController;

// Data
@property (nonatomic, retain) NSManagedObject *detailItem;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Method Signatures
- (void)addButtonPressed;
- (void)configureView;
- (void) getFetchedResultsController;

@end
