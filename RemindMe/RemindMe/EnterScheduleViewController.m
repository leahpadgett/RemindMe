//
//  EnterScheduleViewController.m
//  RemindMe
//
//  Created by Leah Padgett on 5/9/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import "EnterScheduleViewController.h"

@interface EnterScheduleViewController ()

@end

@implementation EnterScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf {

    [self.navigationController popViewControllerAnimated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender {
 [self dismissSelf];
    
 
    
    NSLog(@"Done");
}
@end
