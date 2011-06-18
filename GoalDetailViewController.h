/*********************************************************************
File: GoalDetailViewController.h
 
 Abstract: A detail view controller that manages the widgets for the
 GoalDetailView.xib file.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2011 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h";

@class RootViewController;

@interface GoalDetailViewController : UIViewController <NSFetchedResultsControllerDelegate, SubstitutableDetailViewController , UITableViewDataSource, UITableViewDelegate> {
    NSFetchedResultsController *_fetchedResultsController;
    NSManagedObjectContext *_context;
}

// UI
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIButton *add;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

// Data
@property (nonatomic, retain) NSManagedObject *detailItem;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *context;
//@property (nonatomic, retain) NSMutableArray *arrayData;


- (void) saveGoalItem:(NSString *) goalTxt;


@end
