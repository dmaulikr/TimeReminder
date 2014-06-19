//
//  indigolemonLogViewController.h
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "indigolemonAppDelegate.h"
#import "indigolemonDetailViewController.h"
@interface indigolemonLogViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,UIGestureRecognizerDelegate,FBLoginViewDelegate>


@end
