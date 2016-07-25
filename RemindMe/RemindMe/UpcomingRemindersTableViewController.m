//
//  UpcomingRemindersTableViewController.m
//  RemindMe
//
//  Created by Leah Padgett on 5/9/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import "UpcomingRemindersTableViewController.h"
#import "EnterReminderViewController.h"
#import "CoreDataStack.h"
#import "ReminderEntry.h"
#import "ReminderEntry+CoreDataProperties.h"

@interface UpcomingRemindersTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation UpcomingRemindersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.fetchedResultsController performFetch:nil];
    
   self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:65 / 255.0 green:36 / 255.0 blue:129 / 255.0 alpha:1];
    
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:65 / 255.0 green:36 / 255.0 blue:129 / 255.0 alpha:1]];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"SourceSansProRegular" size:12.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:65 / 255.0 green:36 / 255.0 blue:129 / 255.0 alpha:1];
    label.text = @"My Reminders ";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"edit"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        EnterReminderViewController *destViewController = segue.destinationViewController;
      
       destViewController.entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ReminderEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Make a date formatter which corresponds exactly with the format of the date in core data
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    // Get the date from core data
    NSString *dateString = [[entry valueForKey:@"date"] description];

    
    // Parse from string to date
    NSDate *date = [dateFormatter dateFromString:dateString ];
    
    // Set the date formatter to the format that I actually want
//    [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy h:mm a"];

  
    
    cell.textLabel.text = entry.details;
//    cell.detailTextLabel.text = entry.date.description;
    
        // Set the text on the date label
        cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    
    
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ReminderEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
    
//    [tableView reloadData];

}

//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (NSFetchRequest *)reminderListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ReminderEntry"];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}


- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self reminderListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
          
            case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end








