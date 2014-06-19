//
//  indigolemonSettingsViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/13.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonAppDelegate.h"
@interface indigolemonSettingsViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property(strong,nonatomic)IBOutlet UIButton *instructions_btn;

@property(strong,nonatomic)IBOutlet UITextField *input_password_textfield;
@property(strong,nonatomic)IBOutlet UITextField *confirm_password_textfield;
@property(strong,nonatomic)IBOutlet UIButton *summit_btn;

@property(strong,nonatomic)IBOutlet UIButton *tutorial_btn;

@property(strong,nonatomic)IBOutlet UIButton *demo_btn;
@property(strong,nonatomic)IBOutlet UIButton *tutorial_segue_btn;

@property(strong,nonatomic)IBOutlet UISegmentedControl *switch_seg;
@property(strong,nonatomic)IBOutlet UILabel *pw_label;
@property(strong,nonatomic)IBOutlet UILabel *confirm_label;
@property(strong,nonatomic)IBOutlet UILabel *version_label;
@property(strong,nonatomic)IBOutlet UILabel *copyright_label;

@property(strong,nonatomic)IBOutlet UIButton *team_btn;


-(IBAction)switch_act:(id)sender;

-(IBAction)summit_action:(id)sender;
-(IBAction)tutorial_action:(id)sender;

-(IBAction)team_act:(id)sender;

@end
