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
    
    
    // local notifications
    self.datePicker.timeZone = [NSTimeZone defaultTimeZone];
    NSDate *date = [self.datePicker date];
    NSString *detailsBody = self.reminderTextField.text;
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = detailsBody;
    note.fireDate = date;
    note.timeZone = [NSTimeZone defaultTimeZone];
    note.applicationIconBadgeNumber = 1;
    note.soundName = UILocalNotificationDefaultSoundName;
    //schedule the notification:
    UIApplication *app = [UIApplication sharedApplication];
    // Clear out the old notification before scheduling a new one.
    [app cancelAllLocalNotifications];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert) categories:nil];
    [app registerUserNotificationSettings:settings];
    [app scheduleLocalNotification:note];
    
}


//-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//
//    if (application.applicationState == UIApplicationStateActive) {
//        // inside app
//
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Notification" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            NSLog(@"Ignore");
//        }];
//
//        UIAlertAction *viewAction = [UIAlertAction actionWithTitle:@"View" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [self takeActionWithLocalNotification:notification];
//        }];
//
//        [alertController addAction:ignoreAction];
//        [alertController addAction:viewAction];
//
//        [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
//
//        }];
//
//    } else {
//        // outside app
//        [self takeActionWithLocalNotification:notification];
//    }
//}
//
//
//
//-(void)takeActionWithLocalNotification:(UILocalNotification *)localNotification {
//    NSNumber *notification_id = localNotification.userInfo[@"id"];
//
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action Taken" message:[NSString stringWithFormat:@"We are viewing notification %@", notification_id] preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"OK");
//    }];
//
//    [alertController addAction:okAction];
//
//    [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
//    }];
//
//}








- (IBAction)datePickerAction:(id)sender {
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    
}

@end
