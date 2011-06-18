/*********************************************************************
 File: RootViewController.m
 
 Abstract: This class represents the root view controller or the 
 application's initial popover controller. 
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 13, 2011
 
 Copyright (C) 2010 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "RootViewController.h"
#import "GoalDetailViewController.h"
#import "VitalDetailViewController.h"
#import "MedicineDetailViewController.h"
#import "MealDetailViewController.h"
#import "ExerciseDetailViewController.h"
#import "ContextController.h"
#import "MachineAppDelegate.h"

@interface RootViewController() 
	- (NSArray *) getImageArray;
@end

@implementation RootViewController

@synthesize popoverController, splitViewController, rootPopoverButtonItem, arrayData, subArrayData, imagesList;

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
#pragma mark Custom Implementation

- (NSArray *) getImageArray {
	
	NSString *goalPath = [[NSBundle mainBundle] pathForResource:@"85-trophy@2x" ofType:@"png"];
	NSString *vitalPath = [[NSBundle mainBundle] pathForResource:@"77-ekg@2x" ofType:@"png"];
	NSString *medicinePath = [[NSBundle mainBundle] pathForResource:@"79-medical-bag@2x" ofType:@"png"];
	NSString *mealPath = [[NSBundle mainBundle] pathForResource:@"48-fork-and-knife@2x" ofType:@"png"];
	NSString *exercisePath = [[NSBundle mainBundle] pathForResource:@"63-runner@2x" ofType:@"png"];

	UIImage *goalPathRes = [UIImage imageWithContentsOfFile:goalPath];
	UIImage *vitalPathRes = [UIImage imageWithContentsOfFile:vitalPath];
	UIImage *medicinePathRes = [UIImage imageWithContentsOfFile:medicinePath];
	UIImage *mealPathRes = [UIImage imageWithContentsOfFile:mealPath];
	UIImage *exercisePathRes = [UIImage imageWithContentsOfFile:exercisePath];
	
	NSArray *array = [[NSArray alloc] initWithObjects:goalPathRes,vitalPathRes,medicinePathRes,mealPathRes,exercisePathRes,nil];
	
	return array;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {

	NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"array" ofType:@"plist"];
	NSString *dataFileSub = [[NSBundle mainBundle] pathForResource:@"subarray" ofType:@"plist"];

    imagesList = [self getImageArray];	

	if ([[NSFileManager defaultManager] fileExistsAtPath:dataFile]) {
		arrayData = [[NSArray alloc] initWithContentsOfFile:dataFile];
	} 

	if ([[NSFileManager defaultManager] fileExistsAtPath:dataFileSub]) {
		subArrayData = [[NSArray alloc ]initWithContentsOfFile:dataFileSub];
	} 
	
    [super viewDidLoad];
    
	self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	self.title = @"Menu";
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	// set first row selected
	NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
	
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    // Configure the cell.
	cell.textLabel.text = [arrayData objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [subArrayData objectAtIndex:indexPath.row];
    cell.imageView.image = [imagesList objectAtIndex:indexPath.row];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	ContextController *contextController = [[ContextController alloc] initWithNibName:@"ContextController" bundle:nil];
	MachineAppDelegate *delegate = (MachineAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController <SubstitutableDetailViewController> *detailViewController = nil;

	if (0 == indexPath.row) {
		[delegate setContextKey:@"GoalRec"];
		[contextController setKey:@"GoalRec"];
		contextController.title = @"Goals";
		
		GoalDetailViewController *newDetailViewController = [[GoalDetailViewController alloc] initWithNibName:@"GoalDetailView" bundle:nil];
        detailViewController = newDetailViewController;
	}

	if (1 == indexPath.row) {
		[delegate setContextKey:@"Vital"];
		[contextController setKey:@"Vital"];
		contextController.title = @"Vitals";
		
		VitalDetailViewController *newDetailViewController = [[VitalDetailViewController alloc] initWithNibName:@"VitalDetailView" bundle:nil];
        detailViewController = newDetailViewController;
	}
	
	if (2 == indexPath.row) {
		[delegate setContextKey:@"Medicine"];
		[contextController setKey:@"Medicine"];
		contextController.title = @"Medicines";
		
		MedicineDetailViewController *newDetailViewController = [[MedicineDetailViewController alloc] initWithNibName:@"MedicineDetailView" bundle:nil];
        detailViewController = newDetailViewController;
	}

	if (3 == indexPath.row) {
		[delegate setContextKey:@"Meal"];
		[contextController setKey:@"Meal"];
		contextController.title = @"Meals";
		
		MealDetailViewController *newDetailViewController = [[MealDetailViewController alloc] initWithNibName:@"MealDetailView" bundle:nil];
        detailViewController = newDetailViewController;
	}

	if (4 == indexPath.row) {
		[delegate setContextKey:@"Exercise"];
		[contextController setKey:@"Exercise"];
		contextController.title = @"Exercise";
		
		ExerciseDetailViewController *newDetailViewController = [[ExerciseDetailViewController alloc] initWithNibName:@"ExerciseDetailView" bundle:nil];
        detailViewController = newDetailViewController;
	}
	
	[self.navigationController pushViewController:contextController animated:YES];

    // Update the split view controller's view controllers array.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
	delegate.splitViewController.viewControllers = viewControllers;
    
	// Dismiss the popover if it's present.
    if (popoverController != nil) {
		delegate.popoverController = popoverController;
        [popoverController dismissPopoverAnimated:YES];
    }
	
    // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
    if (rootPopoverButtonItem != nil) {
        [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }

	[delegate setDetailViewController:detailViewController];
	[detailViewController release];
	[viewControllers release];
	[contextController release];
	
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	 if (self) {
		 // Custom initialization.
	 }
	 return self;
}

- (void)viewDidUnload {
	[super viewDidUnload];

	self.splitViewController = nil;
	self.rootPopoverButtonItem = nil;

}

- (void)dealloc {

	[arrayData release];
	[subArrayData release];
	[imagesList release];
	[popoverController release];
    [rootPopoverButtonItem release];

    [super dealloc];
}

@end
