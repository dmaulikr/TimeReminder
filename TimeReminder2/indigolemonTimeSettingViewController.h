//
//  indigolemonTimeSettingViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonAppDelegate.h"

@interface indigolemonTimeSettingViewController : UIViewController

@property (strong,nonatomic) IBOutlet UILabel *start_hour_label;
@property (strong,nonatomic) IBOutlet UILabel *start_min_label;
@property (strong,nonatomic) IBOutlet UILabel *start_sec_label;

@property (strong,nonatomic) IBOutlet UIButton *summit_btn;
@property (strong,nonatomic) IBOutlet UIButton *cancel_btn;


-(IBAction)summit_action:(id)sender;
-(IBAction)cancel_action:(id)sender;


@end
