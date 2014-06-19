//
//  indigolemonAppDelegate.h
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/15.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "indigolemonTutorialViewController.h"
#import <Parse/Parse.h>
#import <Crashlytics/Crashlytics.h>
#import <FacebookSDK/FacebookSDK.h>


@interface indigolemonAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
