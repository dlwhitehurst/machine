/*********************************************************************
 File: GoalAddViewController.m
 
 Abstract: A view controller that manages the modal view for
 the the creation of a new goal item.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 27, 2011
 
 Copyright (C) 2011 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import "GoalAddViewController.h"
#import "MachineAppDelegate.h"
#import "Goal.h"

@implementation GoalAddViewController

@synthesize goalTxt, actualDate, startDate, targetDate, delegate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction) cancel:(id) sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction) done:(id) sender {
	NSLog(@"The goal is %@", goalTxt.text);
	[[self delegate] saveGoalItem:goalTxt.text];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
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
