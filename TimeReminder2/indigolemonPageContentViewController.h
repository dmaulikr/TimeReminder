//
//  indigolemonPageContentViewController.h
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/19.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface indigolemonPageContentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
