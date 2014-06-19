//
//  indigolemonSettingsViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/13.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonSettingsViewController.h"

@interface indigolemonSettingsViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSArray *print;
    UIAlertView *loginalertview;
    UIAlertView *loginalertview2;
    UIAlertView *loginalertview3;
    UIAlertView *loginalertview4;
    UIAlertView *loginalertview5;
    UIAlertView *loginalertview6;

}
@end

@implementation indigolemonSettingsViewController
@synthesize instructions_btn;
@synthesize input_password_textfield;
@synthesize confirm_password_textfield;
@synthesize summit_btn;
@synthesize tutorial_btn;
@synthesize tutorial_segue_btn;
@synthesize demo_btn;
@synthesize switch_seg;
@synthesize pw_label;
@synthesize confirm_label;
@synthesize version_label;
@synthesize copyright_label;

-(void) swipeRight:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        NSLog(@"swipe right");
    [self.tabBarController setSelectedIndex:2];
}

-(void) swipeLeft:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
        NSLog(@"swipe left");
    [self.tabBarController setSelectedIndex:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    
    contextlist = [context executeFetchRequest:request error:&error];
    if(contextlist.count==0)
    {
        NSManagedObject *newModel = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newModel setValue:[NSNumber numberWithInt:0] forKey:@"switch"];
        [context save:&error];
        
        switch_seg.selectedSegmentIndex=0;
        pw_label.hidden=YES;
        input_password_textfield.hidden=YES;
        confirm_label.hidden=YES;
        confirm_password_textfield.hidden=YES;
        
    }
    else
    {
        print = [contextlist objectAtIndex:0];
        NSNumber *temp_seg = [print valueForKey:@"switch"];
        if([temp_seg integerValue]  == 1)
        {
            pw_label.hidden=NO;
            input_password_textfield.hidden=NO;
            confirm_label.hidden=NO;
            confirm_password_textfield.hidden=NO;
            switch_seg.selectedSegmentIndex=1;
        }
        else
        {
            pw_label.hidden=YES;
            input_password_textfield.hidden=YES;
            confirm_label.hidden=YES;
            confirm_password_textfield.hidden=YES;
            switch_seg.selectedSegmentIndex=0;

            UIImage *summit_img = [UIImage imageNamed:@"summit.png"];
            [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
        
            [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(57, 643, 200, 200)];}];
            [UIView animateWithDuration:0.6 animations:^{[self.tutorial_btn setFrame:CGRectMake(503, 643, 200, 200)];}];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [input_password_textfield setKeyboardType:UIKeyboardTypeAlphabet];
    [confirm_password_textfield setKeyboardType:UIKeyboardTypeAlphabet];
    
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];

    version_label.text = @"Version : 1.2";
    version_label.textColor = [UIColor whiteColor];
    
    copyright_label.text = @"Copyright ©                             2014 All Rights Reserved. ";
    copyright_label.textColor = [UIColor whiteColor];    
    
   // self.title =@"其他";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"safe3.jpg"]];
    
    UIImage *summit_img = [UIImage imageNamed:@"summit.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    UIImage *demo_img = [UIImage imageNamed:@"gear3.png"];
    [demo_btn setBackgroundImage:demo_img forState:UIControlStateNormal];
    UIImage *tutorial_img = [UIImage imageNamed:@"tutorial.png"];
    [tutorial_btn setBackgroundImage:tutorial_img forState:UIControlStateNormal];
    

    
    demo_btn.hidden=YES;
    tutorial_segue_btn.hidden=YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    swipeLeft.delegate = self;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    swipeRight.delegate = self;
    
    input_password_textfield.delegate=self;
    confirm_password_textfield.delegate=self;
    //input_password_textfield.placeholder=@"請輸入安全密碼";
    //confirm_password_textfield.placeholder=@"請再次輸入安全密碼";
    
    // init alert start
    loginalertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                message:NSLocalizedString(@"pw1", nil)
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil ];
    loginalertview.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview.tag = 1;
    
    loginalertview2 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                 message:NSLocalizedString(@"pw3", nil)
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                       otherButtonTitles:nil ];
    loginalertview2.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview2.tag = 2;
    
    loginalertview3 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                message:NSLocalizedString(@"pw4", nil)                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil ];
    loginalertview3.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview3.tag = 3;
    
    loginalertview4 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                 message:NSLocalizedString(@"pw5", nil)
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:NSLocalizedString(@"start", nil),nil ];
    loginalertview4.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview4.tag = 4;

    loginalertview6 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"team1", nil)
                                                 message:NSLocalizedString(@"team2", nil)
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                       otherButtonTitles:nil ];
    loginalertview6.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview6.tag = 6;
    
    // init alert end

    
}

-(void)team_act:(id)sender
{
    [loginalertview6 show];
}
-(void)tutorial_action:(id)sender
{
    loginalertview5 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                 message:NSLocalizedString(@"type", nil)
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                      otherButtonTitles:NSLocalizedString(@"tutorial", nil),NSLocalizedString(@"setting_tutorial", nil),nil ];
    loginalertview5.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview5.tag = 5;
    [loginalertview5 show];


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==5 && buttonIndex ==1)
    {
        [self performSegueWithIdentifier:@"settingtodemo"sender:self];

    }
    else if(alertView.tag==5 && buttonIndex ==2)
    {
        [self performSegueWithIdentifier:@"settingtotutorial"sender:self];

    }
    
    if(alertView.tag==4 && buttonIndex ==0)
    {
        NSLog(@"123");
        [self.tabBarController setSelectedIndex:0];
    }

}

-(void)switch_act:(id)sender
{
    NSNumber *temp_seg = [NSNumber numberWithLong:[sender selectedSegmentIndex]];
    if([temp_seg integerValue]  == 1)
    {
        pw_label.hidden=NO;
        input_password_textfield.hidden=NO;
        confirm_label.hidden=NO;
        confirm_password_textfield.hidden=NO;
        
        [input_password_textfield becomeFirstResponder];
    }
    else
    {
        pw_label.hidden=YES;
        input_password_textfield.hidden=YES;
        confirm_label.hidden=YES;
        confirm_password_textfield.hidden=YES;
        
        UIImage *summit_img = [UIImage imageNamed:@"summit.png"];
        [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
        
        [input_password_textfield resignFirstResponder];
        [confirm_password_textfield resignFirstResponder];
        
        [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(57, 643, 200, 200)];}];
        [UIView animateWithDuration:0.6 animations:^{[self.tutorial_btn setFrame:CGRectMake(503, 643, 200, 200)];}];
        
        indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
        context = [appDelegate managedObjectContext];
        NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
        NSFetchRequest *request =[[NSFetchRequest alloc] init];
        [request setEntity:entitydesc];
        NSError *error;
        
        contextlist = [context executeFetchRequest:request error:&error];
        print = [contextlist objectAtIndex:0];
        [print setValue:[NSNumber numberWithInt:0] forKey:@"switch"];
        [context save:&error];
        
        
    }
}

-(void)summit_action:(id)sender
{
    if ([[input_password_textfield text]length]==0)
    {
        [loginalertview show];
    }
    else if ([[confirm_password_textfield text]length]==0)
    {
        [loginalertview2 show];
    }
    else if([input_password_textfield.text isEqualToString:confirm_password_textfield.text])
    {
        
        [input_password_textfield resignFirstResponder];
        [confirm_password_textfield resignFirstResponder];
        
        [loginalertview4 show];
        
        UIImage *summit_img = [UIImage imageNamed:@"summit.png"];
        [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
        
        [input_password_textfield resignFirstResponder];
        [confirm_password_textfield resignFirstResponder];
        
        [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(57, 643, 200, 200)];}];
        [UIView animateWithDuration:0.6 animations:^{[self.tutorial_btn setFrame:CGRectMake(503, 643, 200, 200)];}];
        
        
            indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
            context = [appDelegate managedObjectContext];
            NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
            NSFetchRequest *request =[[NSFetchRequest alloc] init];
            [request setEntity:entitydesc];
            NSError *error;
            
            contextlist = [context executeFetchRequest:request error:&error];
        
        if(contextlist.count==0)
        {
            NSManagedObject *newlog = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
            [newlog setValue:input_password_textfield.text forKey:@"password"];
            [context save:&error];
            
            print = [contextlist objectAtIndex:0];
            [print setValue:[NSNumber numberWithInt:1] forKey:@"switch"];
            [context save:&error];

        }
        else
        {
            print = [contextlist objectAtIndex:0];
            [print setValue:input_password_textfield.text forKey:@"password"];
            [context save:&error];
            
            print = [contextlist objectAtIndex:0];
            [print setValue:[NSNumber numberWithInt:1] forKey:@"switch"];
            [context save:&error];
        }
        input_password_textfield.text=@"";
        confirm_password_textfield.text=@"";
    }
    else
    {
        [loginalertview3 show];
        confirm_password_textfield.text=@"";
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIImage *summit_img_v = [UIImage imageNamed:@"summit_v2.png"];
    [summit_btn setBackgroundImage:summit_img_v forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(57, 543, 200, 200)];}];
    [UIView animateWithDuration:0.6 animations:^{[self.tutorial_btn setFrame:CGRectMake(503, 543, 200, 200)];}];
    
    return YES;
}


//點擊鍵盤上的return後隱藏鍵盤

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == input_password_textfield)
    {
        [input_password_textfield resignFirstResponder];
        [confirm_password_textfield becomeFirstResponder];
    }
    if (theTextField == confirm_password_textfield)
    {
        [self summit_action:@"123"];
    }
    return YES;
}
//點擊文字框以外的地方隱藏鍵盤

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [input_password_textfield resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
    [confirm_password_textfield resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(57, 643, 200, 200)];}];
    [UIView animateWithDuration:0.6 animations:^{[self.tutorial_btn setFrame:CGRectMake(503, 643, 200, 200)];}];
    
    UIImage *summit_img = [UIImage imageNamed:@"summit.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    
    switch_seg.selectedSegmentIndex=0;
    pw_label.hidden=YES;
    input_password_textfield.hidden=YES;
    confirm_label.hidden=YES;
    confirm_password_textfield.hidden=YES;
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    
    contextlist = [context executeFetchRequest:request error:&error];
    print = [contextlist objectAtIndex:0];
    [print setValue:[NSNumber numberWithInt:0] forKey:@"switch"];
    [context save:&error];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
