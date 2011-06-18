/*********************************************************************
 File: ExerciseDetailViewController.m
 
 Abstract: A detail view controller that manages the widgets for the
 ExerciseDetailView.xib file.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "ExerciseDetailViewController.h"
#import "RootViewController.h"
#import "MachineAppDelegate.h"
#import "Exercise.h"


@implementation ExerciseDetailViewController

@synthesize detailItem, toolbar, managedObjectContext, fetchedResultsController;

- (void)configureView {
	// update the UI with the view details
}

#pragma mark -
#pragma mark Data Methods

- (void) getFetchedResultsController {
	
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.managedObjectContext = delegate.managedObjectContext;
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"Exercise" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"title" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
    [fetchRequest setFetchBatchSize:20];
	
    NSFetchedResultsController *theFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:managedObjectContext sectionNameKeyPath:nil 
												   cacheName:@"Root"];
    
	self.fetchedResultsController = theFetchedResultsController;
    fetchedResultsController.delegate = self;
	
    [sort release];
    [fetchRequest release];
    [theFetchedResultsController release];
	
}

- (void)addButtonPressed {
	
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
	//NSLog(@"Button picked up key value and key is: %@", delegate.contextKey);
	
	//NSString *strKey = delegate.contextKey;
	
	// persist
	[self getFetchedResultsController];
	
	// Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    //NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
	
	Exercise *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" 
													inManagedObjectContext:context];
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
	NSString *dateString = [dateFormat stringFromDate:today];
	[dateFormat release];
	
	[newExercise setValue:dateString forKey:@"title"];
	[newExercise setValue:@"Daily Exercise" forKey:@"subtitle"];
	[newExercise setValue:today forKey:@"exercise_date"];
	
	
	// Save the context
	if (![managedObjectContext save:nil]) { 
		// error checking
	}
	
	[delegate refreshDisplay];
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
