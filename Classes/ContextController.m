/*********************************************************************
 File: ContextController.m
 
 Abstract: A second level context controller that manages the table 
 view for the particular context selected from the root view.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "ContextController.h"
#import "MachineAppDelegate.h"
#import "GoalRec.h"
#import "Vital.h"
#import "Medicine.h"
#import "Meal.h"
#import "Exercise.h"

@interface ContextController()
	-(void) refreshTableView;
	-(void) deleteTableRow;
@end

@implementation ContextController

@synthesize key, tableView, splitViewController, popoverController, rootPopoverButtonItem;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;


- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Menu";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}


#pragma mark -
#pragma mark Data Methods


/**
 Returns the fetchedResultsController for this view controller.
 If the fetchedResultsController doesn't already exist, it is created and bound to the delegate's managedObjectContext.
 */

- (NSFetchedResultsController *)fetchedResultsController:(NSString *) objKey {
	
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.context = delegate.managedObjectContext;
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:objKey inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"title" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:_context sectionNameKeyPath:nil 
												   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
	
    [sort release];
    [fetchRequest release];
    [theFetchedResultsController release];
	
    return _fetchedResultsController;    
	
}

#pragma mark -
#pragma mark Custom TableView Methods

/*
 * This method is called by the application delegate to refresh the UITableView
 */
- (void) refreshTableView {
	
    MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate setContextController:self];
	NSString *driver = delegate.contextKey;

	if (driver && ![driver isEqual:@""]) {
		
		NSError *error;
		if (![[self fetchedResultsController:driver] performFetch:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@", error);
			exit(-1);  // Fail
		}

		NSMutableArray	*insertIndexPaths = [[NSMutableArray alloc] init];
		NSIndexPath *ind;
		NSIndexPath *beginIndex = 0;
		NSIndexPath *endIndex = (NSIndexPath *) [[self.fetchedResultsController fetchedObjects] count];
		
		for (ind = beginIndex; ind <= endIndex; ind++) {
			NSIndexPath	*newPath =  [NSIndexPath indexPathForRow:(int)ind inSection:0];
			[insertIndexPaths addObject:newPath];
		}
		
		[self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
	}
}

/*
 * This method is used to delete the physical row
 */
- (void) deleteTableRow {
	
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate setContextController:self];
	NSString *driver = delegate.contextKey;
	
	if (driver && ![driver isEqual:@""]) {

		NSError *error;
		if (![[self fetchedResultsController:driver] performFetch:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@", error);
			exit(-1);  // Fail
		}
		
		NSMutableArray	*deleteIndexPaths = [[NSMutableArray alloc] init];
		NSIndexPath *ind;
		NSIndexPath *beginIndex = 0;
		NSIndexPath *endIndex = (NSIndexPath *) [[self.fetchedResultsController fetchedObjects] count];
		
		for (ind = beginIndex; ind <= endIndex; ind++) {
			NSIndexPath	*newPath =  [NSIndexPath indexPathForRow:(int)ind inSection:0];
			[deleteIndexPaths addObject:newPath];
		}
		
		[self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
	}
	
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	// set first row selected
	if ([self.tableView numberOfRowsInSection:0] > 0) {
		NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
	}
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 [super viewDidLoad];

	 [self.tableView setDelegate:self];

	 MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	 [delegate setContextController:self];
	 NSString *driver = delegate.contextKey;
	 
	 if (driver && ![driver isEqual:@""]) {

		 NSError *error;
		 if (![[self fetchedResultsController:driver] performFetch:&error]) {
			 // Update to handle the error appropriately.
			 NSLog(@"Unresolved error %@", error);
			 exit(-1);  // Fail
		 }		 
	 }

	 // add an edit button
	 self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = 
	[[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *obj = [_fetchedResultsController objectAtIndexPath:indexPath];
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];

	// Goal Handling
	if ([[obj entity].name isEqualToString:@"GoalRec"]) {
        NSLog(@"Selected a Goal object!");
		[delegate.detailViewController setDetailItem:obj];
    }
	if ([[obj entity].name isEqualToString:@"Vital"]) {
        NSLog(@"Selected a Vital object!");
		[delegate.detailViewController setDetailItem:obj];
    }
	if ([[obj entity].name isEqualToString:@"Medicine"]) {
        NSLog(@"Selected a Medicine object!");
		[delegate.detailViewController setDetailItem:obj];
    }
	if ([[obj entity].name isEqualToString:@"Meal"]) {
        NSLog(@"Selected a Meal object!");
		[delegate.detailViewController setDetailItem:obj];
    }
	if ([[obj entity].name isEqualToString:@"Exercise"]) {
        NSLog(@"Selected an Exercise object!");
		[delegate.detailViewController setDetailItem:obj];
    }

	// Dismiss the popover if it's present.
    if (delegate.popoverController != nil) {
        [delegate.popoverController dismissPopoverAnimated:YES];
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tmpTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tmpTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	GoalRec *goalRec = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = goalRec.title;
    cell.detailTextLabel.text = goalRec.subtitle;

    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)mTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

	// Deleting?
	if (editingStyle == UITableViewCellEditingStyleDelete) {

		// Set our delegate and get the driver key
		MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
		[delegate setContextController:self];
		NSString *driver = delegate.contextKey;
		
		// Do our deletion 
		if (driver && ![driver isEqual:@""]) {

			NSError *error;
			if (![[self fetchedResultsController:driver] performFetch:&error]) {
				// Update to handle the error appropriately.
				NSLog(@"Unresolved error %@", error);
				exit(-1);  // Fail
			}
			
			if ([driver isEqual:@"GoalRec"]) {
				GoalRec *goalRec = [_fetchedResultsController objectAtIndexPath:indexPath];
				[delegate.managedObjectContext deleteObject:goalRec];
			}
			if ([driver isEqual:@"Vital"]) {
				Vital *vital = [_fetchedResultsController objectAtIndexPath:indexPath];
				[delegate.managedObjectContext deleteObject:vital];
			}
			if ([driver isEqual:@"Medicine"]) {
				Medicine *medicine = [_fetchedResultsController objectAtIndexPath:indexPath];
				[delegate.managedObjectContext deleteObject:medicine];
			}
			if ([driver isEqual:@"Meal"]) {
				Meal *meal = [_fetchedResultsController objectAtIndexPath:indexPath];
				[delegate.managedObjectContext deleteObject:meal];
			}
			if ([driver isEqual:@"Exercise"]) {
				Exercise *exercise = [_fetchedResultsController objectAtIndexPath:indexPath];
				[delegate.managedObjectContext deleteObject:exercise];
			}

			// Save the context
			NSError *saveError = nil;
			if (![delegate.managedObjectContext save:&saveError]) 
			{
				NSLog(@"ERROR %@, %@", error, [saveError userInfo]);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Critical Core Data Error"
									  
																message:@"Error saving the ManagedObjectContext" 
															   delegate:nil 
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				
				[alert show];
				[alert release];
				
			}
			
			[self deleteTableRow];
		}
	}       
}
		 
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    self.fetchedResultsController = nil;
}


- (void)dealloc {
    [super dealloc];
	self.fetchedResultsController = nil;
}

@end
