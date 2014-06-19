//
//  indigolemonPickerViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonAppDelegate.h"

@interface indigolemonPickerViewController : UIViewController<NSXMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic) NSMutableArray *arrayDay;
@property (nonatomic) NSMutableArray *arrayDay2;

@property (strong,nonatomic) NSManagedObjectModel *model;
@property (strong,nonatomic) NSString *start_hour;
@property (strong,nonatomic) NSString *start_min;
@property (strong,nonatomic) NSString *start_sec;

@property (strong,nonatomic) IBOutlet UIButton *summit_btn;

-(IBAction)donebtn:(id)sender;


@end
