//
//  AppDelegate.m
//  RemindMe
//
//  Created by Leah Padgett on 4/22/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//

#import "AppDelegate.h"
#import "EnterReminderViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
//
//    
//    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
//    [self generateLocalNotification];
    
 return YES;
}

//-(void)generateLocalNotification {
//    
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:15];
//    localNotification.alertBody = @"My First Local Notification";
//    localNotification.applicationIconBadgeNumber = 3;
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    localNotification.userInfo = @{@"id" : @42};
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    
//}
//

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    if (application.applicationState == UIApplicationStateActive) {
        // inside app
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Notification" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"Ignore");
        }];
        
        UIAlertAction *viewAction = [UIAlertAction actionWithTitle:@"View" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self takeActionWithLocalNotification:notification];
        }];
        
        [alertController addAction:ignoreAction];
        [alertController addAction:viewAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
        
    } else {
        // outside app
        [self takeActionWithLocalNotification:notification];
    }
}


-(void)takeActionWithLocalNotification:(UILocalNotification *)localNotification {
    NSString *notification_id = localNotification.alertBody;
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"This is a reminder!" message:[NSString stringWithFormat:@"%@", notification_id] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:okAction];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
    }];
    
}
//
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   
}

@end
