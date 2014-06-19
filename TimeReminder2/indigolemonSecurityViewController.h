//
//  indigolemonSecurityViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/13.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indigolemonAppDelegate.h"

@interface indigolemonSecurityViewController : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic) IBOutlet UITextField *input_textfield;
@property(strong,nonatomic) IBOutlet UIButton *summit_btn;

-(IBAction)summit_action:(id)sender;



@end
