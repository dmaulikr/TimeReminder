//
//  indigolemonClockViewController.h
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/18.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "indigolemonAppDelegate.h"

@interface indigolemonClockViewController : UIViewController<NSXMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic) NSMutableArray *arrayDay;
@property (nonatomic) NSMutableArray *arrayDay2;

@property (strong,nonatomic) NSManagedObjectModel *model;
@property (strong,nonatomic) NSString *start_hour;
@property (strong,nonatomic) NSString *start_min;
@property (strong,nonatomic) NSString *start_sec;

@property (strong,nonatomic) IBOutlet UIButton *summit_btn;
@property (strong,nonatomic) IBOutlet UIButton *cancel_btn;

@property (strong,nonatomic) IBOutlet UILabel *show_time_label;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;


-(IBAction)summit_action:(id)sender;
-(IBAction)cancel_action:(id)sender;
-(IBAction)pickerview_show_action:(id)sender;



@end
