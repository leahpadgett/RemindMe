//
//  EnterReminderViewController.m
//  RemindMe
//
//  Created by Leah Padgett on 5/9/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import "EnterReminderViewController.h"

@interface EnterReminderViewController ()

@end

@implementation EnterReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    
    
}


- (IBAction)CancelButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
