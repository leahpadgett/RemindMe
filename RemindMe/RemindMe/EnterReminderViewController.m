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
    
    
}

-(void)insertReminderDetails {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    ReminderEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    entry.details = self.reminderTextField.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [coreDataStack saveContext];
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    
    
      [self.navigationController popViewControllerAnimated:YES];
  
    
}

- (IBAction)SaveButtonPressed:(id)sender {
    [self insertReminderDetails];
      [self.navigationController popViewControllerAnimated:YES];

}




@end
