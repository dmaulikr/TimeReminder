//
//  indigolemonDemoViewController.h
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/19.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonPageContentViewController.h"
#import "indigolemonSettingsViewController.h"

@interface indigolemonDemoViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) IBOutlet UIButton *back_brn;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@property (strong, nonatomic) IBOutlet UIButton *demototutorial_btn;

- (IBAction)back_action:(id)sender;

@end
