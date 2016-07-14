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

@interface EnterReminderViewController () <UITextViewDelegate>



@end

@implementation EnterReminderViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _reminderTextField.delegate = self;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    
    
  
    if (self.entry != nil) {
        self.reminderTextField.text = self.entry.details;
        self.datePicker.date = self.entry.date;
     
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
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



//
//// Dismiss keyboard when another part of app is touched.
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //hides keyboard when another part of layout was touched
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}

- (IBAction)datePickerAction:(id)sender {
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    
}

@end
