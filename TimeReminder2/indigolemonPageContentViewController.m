//
//  indigolemonPageContentViewController.m
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/19.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonPageContentViewController.h"

@interface indigolemonPageContentViewController ()
@end

@implementation indigolemonPageContentViewController
@synthesize title_label;
@synthesize backgroundImageView;
@synthesize pageIndex;
@synthesize titleText;
@synthesize imageFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title_label.text = self.titleText;
    self.title_label.textColor=[UIColor whiteColor];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
