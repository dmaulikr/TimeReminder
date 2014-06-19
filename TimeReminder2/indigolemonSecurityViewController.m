//
//  indigolemonSecurityViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/13.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonSecurityViewController.h"

@interface indigolemonSecurityViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSString *password;
    NSArray *print;
    UIAlertView *loginalertview;
    UIAlertView *loginalertview2;

}
@end

@implementation indigolemonSecurityViewController
@synthesize input_textfield;
@synthesize summit_btn;

-(void)viewWillAppear:(BOOL)animated
{
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    if(contextlist.count>0)
    {
        print = [contextlist objectAtIndex:0];
        password = [print valueForKey:@"password"];
    }
    else
    {
        [self quit];
    }

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //input_textfield.placeholder=@"請輸入安全密碼";
    input_textfield.delegate = self;
    [input_textfield setKeyboardType:UIKeyboardTypeAlphabet];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    UIImage *summit_img = [UIImage imageNamed:@"check.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    
    UIView *view =[[UIView alloc] initWithFrame: CGRectMake(10, 10, 100, 200)];
    [self.view addSubview:view];
    
    // init alert start
    loginalertview = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"pw1", nil)
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil ];
    loginalertview.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview.tag = 1;
    loginalertview2 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"pw2", nil)
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil ];
    loginalertview2.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview2.tag = 2;

    // init alert end
    [input_textfield becomeFirstResponder];
    

}

-(void)quit
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)summit_action:(id)sender
{
    if(contextlist.count==0)
    {
        [self quit];
    }
    else if([input_textfield.text isEqualToString:password])
    {
        [self quit];
        [input_textfield resignFirstResponder];
        NSLog(@"%@",password);
    }
    else if( [[input_textfield  text]length]==0)
    {
        [loginalertview show];
    }
    else
    {
        [loginalertview2 show];
        input_textfield.text = @"";
    }
    
}


//點擊鍵盤上的return後隱藏鍵盤

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == input_textfield)
    {
        [input_textfield resignFirstResponder];
    }
    return YES;
}

//點擊文字框以外的地方隱藏鍵盤

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [input_textfield resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
