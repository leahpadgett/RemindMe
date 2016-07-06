//
//  EnterReminderViewController.m
//  RemindMe
//
//  Created by Leah Padgett on 5/9/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import "EnterReminderViewController.h"
#import "UpcomingRemindersTableViewController.h"
#import "CoreDataStack.h"
#import "ReminderEntry+CoreDataProperties.h"
#import "ReminderEntry.h"

@interface EnterReminderViewController ()



@end

@implementation EnterReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    
    
    if (self.entry != nil) {
        self.reminderTextField.text = self.entry.details;
        self.datePicker.date = self.entry.date;
    }
    

    
}



-(void)insertReminderDetails {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    ReminderEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.details = self.reminderTextField.text;
    entry.date =  self.datePicker.date;
   
    [coreDataStack saveContext];
    
}


- (void)updateReminderEntry {
    self.entry.details = self.reminderTextField.text;
    self.entry.date = self.datePicker.date;
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    

}

- (IBAction)CancelButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)SaveButtonPressed:(id)sender {
    if (self.entry != nil) {
        [self updateReminderEntry];
    } else {
        [self insertReminderDetails];
    }
[self.navigationController popViewControllerAnimated:YES];
    
}






- (IBAction)datePickerAction:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    
}

@end
