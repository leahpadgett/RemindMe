//
//  EnterReminderViewController.h
//  RemindMe
//
//  Created by Leah Padgett on 5/9/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReminderEntry;


@interface EnterReminderViewController : UIViewController <UITextViewDelegate> {

}

- (IBAction)CancelButtonPressed:(id)sender;
- (IBAction)SaveButtonPressed:(id)sender;

@property (nonatomic, strong) ReminderEntry *entry;

@property (strong, nonatomic) IBOutlet UITextView *reminderTextField;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)datePickerAction:(id)sender;

@end
