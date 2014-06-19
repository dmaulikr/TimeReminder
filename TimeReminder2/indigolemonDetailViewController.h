//
//  indigolemonDetailViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonAppDelegate.h"

@interface indigolemonDetailViewController : UIViewController
@property (strong,nonatomic) IBOutlet UILabel *during_label;
@property (strong,nonatomic) IBOutlet UILabel *start_time_label;
@property (strong,nonatomic) IBOutlet UILabel *end_time_label;
@property NSInteger passvalue;

@end
