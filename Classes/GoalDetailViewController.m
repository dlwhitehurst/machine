/*********************************************************************
 File: GoalDetailViewController.m
 
 Abstract: A detail view controller that manages the widgets for the
 GoalDetailView.xib file.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2011 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "GoalDetailViewController.h"
#import "GoalAddViewController.h"
#import "RootViewController.h"
#import "MachineAppDelegate.h"
#import "GoalRec.h"
#import "Goal.h"

@interface GoalDetailViewController ()
- (void)addButtonPressed;
//- (void) getFetchedResultsController;
//- (void) buildTableArray;
//- (void)configureView;
- (IBAction) addGoalItem:(id) sender;
- (void) saveGoalItem:(NSString *) goalTxt;
- (void) refreshTableView;

@end

@implementation GoalDetailViewController

@synthesize detailItem, add, toolbar, tableView;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = 
	[[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Identifier for retrieving reusable cells.
	static NSString *cellIdentifier = @"MyCellIdentifier";
	
	// Attempt to request the reusable cell.
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	// No cell available - create one.
	if(cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:cellIdentifier];
	}
	
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // title
	cell.textLabel.text = [[managedObject valueForKey:@"goal"] description];

	NSDate *date = [managedObject valueForKey:@"start_date"];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSString *dateString = [dateFormat stringFromDate:date];
	[dateFormat release];

	// subtitle
	cell.detailTextLabel.text = dateString;
	
	return cell;
}

#pragma mark -
#pragma mark Data Methods

/**
 Saves the managedObjectContext
 */

- (void) saveContext {

	NSError *error = nil;
	if (![_context save:&error]) 
	{
        NSLog(@"ERROR %@, %@", error, [error userInfo]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Critical Core Data Error"
							  
                                                        message:@"Error saving the ManagedObjectContext" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
		
        [alert show];
        [alert release];
		
	}
}

/**
  Returns the fetchedResultsController for this view controller.
  If the fetchedResultsController doesn't already exist, it is created and bound to the delegate's managedObjectContext.
 */

- (NSFetchedResultsController *)fetchedResultsController {
	
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"Goal" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"start_date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	

    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:_context sectionNameKeyPath:nil 
												   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
	
	
	NSError *anError = nil;
	[theFetchedResultsController performFetch:&anError];
	//NSMutableArray *itemArray = [[theFetchedResultsController fetchedObjects] mutableCopy];

    [sort release];
    [fetchRequest release];
    [theFetchedResultsController release];

	
    return _fetchedResultsController;    
	
}

- (void)addButtonPressed {
	
	GoalRec *newGoalRec = [NSEntityDescription insertNewObjectForEntityForName:@"GoalRec" 
													  inManagedObjectContext:_context];
		
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSString *dateString = [dateFormat stringFromDate:today];
	[dateFormat release];
	
	[newGoalRec setValue:dateString forKey:@"title"];
	[newGoalRec setValue:@"List of Goals" forKey:@"subtitle"];
	[newGoalRec setValue:today forKey:@"goal_date"];
		
	
	// Save the context
	[self saveContext];
	
}

- (void)setDetailItem:(NSManagedObject *)managedObject {
    
	if (detailItem != managedObject) {
		[detailItem release];
		detailItem = [managedObject retain];
		
	}
}

#pragma mark -
#pragma mark Custom UI Methods

- (IBAction) addGoalItem:(id) sender {
	NSLog(@"Why did you push the Add button?");

	if (detailItem != nil) {
		
		GoalAddViewController *addController = [[GoalAddViewController alloc] initWithNibName:@"GoalAddView" bundle:nil];
		addController.modalPresentationStyle = UIModalPresentationFormSheet;
		[addController setDelegate:self];
		[self presentModalViewController:addController animated:YES];
		[addController release];
		 
	}
	
}

- (void) saveGoalItem:(NSString *) goalTxt {

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"Goal" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"title" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:_context sectionNameKeyPath:nil 
												   cacheName:@"Root"];
	
	NSError *anError = nil;
	[theFetchedResultsController performFetch:&anError];
	NSMutableArray *goalArray = [[theFetchedResultsController fetchedObjects] mutableCopy];
	Goal *goal;
	int i;
	int arrayCount = [goalArray count];
	
	for (i = 0; i < arrayCount; i++) {
		if([detailItem isEqual:[goalArray objectAtIndex:i]]) {
			goal = [goalArray objectAtIndex:i];
		}
	}

	GoalRec *goalRec = [NSEntityDescription insertNewObjectForEntityForName:@"GoalRec" 
														  inManagedObjectContext:_context];

	NSDate *today = [NSDate date];
	[goalRec setValue:today forKey:@"start_date"];
	[goalRec setValue:goalTxt forKey:@"goal"];
	[goalRec setParent:goal];
	
	NSMutableSet *children = [goal mutableSetValueForKey:@"children"];
	[children addObject:goal];
	
	// Save the context
	[self saveContext];


	[theFetchedResultsController release];
	
	// refresh/adjust table
	[self refreshTableView];
	
}

/**
 Adjusts the UITable indexes after a fresh data fetch
 */

- (void) refreshTableView {

	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
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


#pragma mark -
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {

	NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *BtnSpace = [[[UIBarButtonItem alloc]
								  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
								  target:self 
								  action:nil]
								 autorelease];
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
								   target:self 
								   action:@selector(addButtonPressed)] 
								  autorelease];
	addButton.style = UIBarButtonItemStyleBordered;
	
	[toolbar setItems:[NSArray arrayWithObjects:BtnSpace, addButton, nil] animated:YES];
	
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.context = delegate.managedObjectContext;
	
	//[self fetchedResultsController];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)dealloc {
    [super dealloc];
}


@end
