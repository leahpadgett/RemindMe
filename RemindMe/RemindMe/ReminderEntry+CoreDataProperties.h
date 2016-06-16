//
//  ReminderEntry+CoreDataProperties.h
//  RemindMe
//
//  Created by Leah Padgett on 6/8/16.
//  Copyright © 2016 Leah Padgett. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ReminderEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReminderEntry (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *details;

@end

NS_ASSUME_NONNULL_END
