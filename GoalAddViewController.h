/*********************************************************************
 File: GoalAddViewController.h
 
 Abstract: The view controller that manages the modal view for
 the the creation of a new goal item.
 
 Version: 1.0
 Author: David L. Whitehurst
 Created: March 27, 2011
 
 Copyright (C) 2011 David L. Whitehurst. All Rights Reserved.
 
 ********************************************************************/

#import <UIKit/UIKit.h>

@class GoalDetailViewController;

@interface GoalAddViewController : UIViewController {}

@property(nonatomic, retain) IBOutlet UITextField *goalTxt;
@property(nonatomic, retain) IBOutlet UIDatePicker *actualDate;
@property(nonatomic, retain) IBOutlet UIDatePicker *startDate;
@property(nonatomic, retain) IBOutlet UIDatePicker *targetDate;
@property(nonatomic, assign) GoalDetailViewController *delegate;

// use with edit controller
//@property(nonatomic, retain) GoalItem *goalItem;

- (IBAction) done:(id) sender;
- (IBAction) cancel:(id) sender;


@end
