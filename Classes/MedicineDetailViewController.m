/*********************************************************************
 File: MedicineDetailViewController.m
 
 Abstract: A detail view controller that manages the widgets for the
 MedicineDetailView.xib file.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "MedicineDetailViewController.h"
#import "MedicineAddViewController.h"
#import "RootViewController.h"
#import "MachineAppDelegate.h"
#import "Medicine.h"
#import "RxItem.h"

@interface MedicineDetailViewController ()
- (void) addButtonPressed;
- (void) getFetchedResultsController;
- (IBAction) addMedicineItem:(id) sender;
@end

@implementation MedicineDetailViewController

@synthesize detailItem, add, toolbar, tableView;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;


#pragma mark -
#pragma mark Data Methods

/**
 * Sets the detail or subject item
 */

- (void)setDetailItem:(NSManagedObject *)managedObject {
    
	if (detailItem != managedObject) {
		[detailItem release];
		detailItem = [managedObject retain];
		
	}
}

/**
 * Saves the managedObjectContext
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

#pragma mark -
#pragma mark Custom UI Methods

- (IBAction) addMedicineItem:(id) sender {
	
	if (detailItem != nil) {
		
		MedicineAddViewController *addController = [[MedicineAddViewController alloc] initWithNibName:@"MedicineAddView" bundle:nil];
		addController.modalPresentationStyle = UIModalPresentationFormSheet;
		[addController setDelegate:self];
		[self presentModalViewController:addController animated:YES];
		[addController release];
		
	}
	
}

#pragma mark -
#pragma mark Data Methods

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
								   entityForName:@"RxItem" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"name" ascending:NO];
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
	
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	//NSLog(@"Button picked up key value and key is: %@", delegate.contextKey);
	
	//NSString *strKey = delegate.contextKey;
	
	// persist
	[self getFetchedResultsController];
	
	// Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController _context];
    //NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
	
	Medicine *newMedicine = [NSEntityDescription insertNewObjectForEntityForName:@"Medicine" 
													inManagedObjectContext:context];
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSString *dateString = [dateFormat stringFromDate:today];
	[dateFormat release];
	
	[newMedicine setValue:dateString forKey:@"title"];
	[newMedicine setValue:@"Prescription Listing" forKey:@"subtitle"];
	[newMedicine setValue:today forKey:@"medicine_date"];
	
	
	// Save the context
	[self saveContext];
	
	//[delegate refreshDisplay];
}

#pragma mark -
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
	NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [toolbar setItems:itemsArray animated:NO];
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
	cell.textLabel.text = [[managedObject valueForKey:@"medicine"] description];
	
	NSDate *date = [managedObject valueForKey:@"start_date"];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSString *dateString = [dateFormat stringFromDate:date];
	[dateFormat release];
	
	// subtitle
	cell.detailTextLabel.text = dateString;
	
	return cell;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
