//
//  indigolemonStopWatchViewController.m
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/18.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonStopWatchViewController.h"

@interface indigolemonStopWatchViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSNumber *myNumber;
    
    UIAlertView *alertview;
    UIAlertView *alertview2;
    UIAlertView *alertview3;
    UIAlertView *alertview5;

    NSString *alert_msg;
    
    NSString *start_sec;
    NSNumber *alltime;
    NSDate *start_time;
    NSDate *end_time;
    NSDate *now;
    NSNumber *during;
    NSString *during_msg;
    int pickerview_show;
    NSTimer *timer;


}
@end

@implementation indigolemonStopWatchViewController
@synthesize pickerView;

@synthesize arrayDay;
@synthesize arrayDay2;

@synthesize start_hour;
@synthesize start_min;
@synthesize start_sec;
@synthesize model;
@synthesize summit_btn;
@synthesize cancel_btn;
@synthesize show_time_label;
@synthesize activityIndicatorView;

-(void)viewDidDisappear:(BOOL)animated
{
    [self pickerview_disappear];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
   // self.title=@"計時器";

  //  [self show_number];

}
-(void) swipeRight:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        NSLog(@"swipe right");
      [self.tabBarController setSelectedIndex:0];
}

-(void) swipeLeft:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
        NSLog(@"swipe left");
    [self.tabBarController setSelectedIndex:2];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stopwatch_3.jpg"]];
    
    
    UIImage *summit_img = [UIImage imageNamed:@"play02.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    UIImage *cancel_img = [UIImage imageNamed:@"stopwatch3_btn.png"];
    [cancel_btn setBackgroundImage:cancel_img forState:UIControlStateNormal];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    swipeLeft.delegate = self;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    swipeRight.delegate = self;

    arrayDay = [[NSMutableArray alloc] init];
    [arrayDay addObject:@"00"];
    [arrayDay addObject:@"01"];
    [arrayDay addObject:@"02"];
    [arrayDay addObject:@"03"];
    [arrayDay addObject:@"04"];
    [arrayDay addObject:@"05"];
    [arrayDay addObject:@"06"];
    [arrayDay addObject:@"07"];
    [arrayDay addObject:@"08"];
    [arrayDay addObject:@"09"];
    [arrayDay addObject:@"10"];
    [arrayDay addObject:@"11"];
    [arrayDay addObject:@"12"];
    [arrayDay addObject:@"13"];
    [arrayDay addObject:@"14"];
    [arrayDay addObject:@"15"];
    [arrayDay addObject:@"16"];
    [arrayDay addObject:@"17"];
    [arrayDay addObject:@"18"];
    [arrayDay addObject:@"19"];
    [arrayDay addObject:@"20"];
    [arrayDay addObject:@"21"];
    [arrayDay addObject:@"22"];
    [arrayDay addObject:@"23"];
    [arrayDay addObject:@"24"];
    [arrayDay addObject:@"25"];
    [arrayDay addObject:@"26"];
    [arrayDay addObject:@"27"];
    [arrayDay addObject:@"28"];
    [arrayDay addObject:@"29"];
    [arrayDay addObject:@"30"];
    [arrayDay addObject:@"31"];
    [arrayDay addObject:@"32"];
    [arrayDay addObject:@"33"];
    [arrayDay addObject:@"34"];
    [arrayDay addObject:@"35"];
    [arrayDay addObject:@"36"];
    [arrayDay addObject:@"37"];
    [arrayDay addObject:@"38"];
    [arrayDay addObject:@"39"];
    [arrayDay addObject:@"40"];
    [arrayDay addObject:@"41"];
    [arrayDay addObject:@"42"];
    [arrayDay addObject:@"43"];
    [arrayDay addObject:@"44"];
    [arrayDay addObject:@"45"];
    [arrayDay addObject:@"46"];
    [arrayDay addObject:@"47"];
    [arrayDay addObject:@"48"];
    [arrayDay addObject:@"49"];
    [arrayDay addObject:@"50"];
    [arrayDay addObject:@"51"];
    [arrayDay addObject:@"52"];
    [arrayDay addObject:@"53"];
    [arrayDay addObject:@"54"];
    [arrayDay addObject:@"55"];
    [arrayDay addObject:@"56"];
    [arrayDay addObject:@"57"];
    [arrayDay addObject:@"58"];
    [arrayDay addObject:@"59"];
    
    arrayDay2 = [[NSMutableArray alloc] init];
    [arrayDay2 addObject:@"00"];
    [arrayDay2 addObject:@"01"];
    [arrayDay2 addObject:@"02"];
    [arrayDay2 addObject:@"03"];
    [arrayDay2 addObject:@"04"];
    [arrayDay2 addObject:@"05"];
    [arrayDay2 addObject:@"06"];
    [arrayDay2 addObject:@"07"];
    [arrayDay2 addObject:@"08"];
    [arrayDay2 addObject:@"09"];
    [arrayDay2 addObject:@"10"];
    [arrayDay2 addObject:@"11"];
    [arrayDay2 addObject:@"12"];
    [arrayDay2 addObject:@"13"];
    [arrayDay2 addObject:@"14"];
    [arrayDay2 addObject:@"15"];
    [arrayDay2 addObject:@"16"];
    [arrayDay2 addObject:@"17"];
    [arrayDay2 addObject:@"18"];
    [arrayDay2 addObject:@"19"];
    [arrayDay2 addObject:@"20"];
    [arrayDay2 addObject:@"21"];
    [arrayDay2 addObject:@"22"];
    [arrayDay2 addObject:@"23"];
    
    
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height > 568)
    {
        pickerView.transform = CGAffineTransformMakeScale(2, 2);
    }
    else
    {
        pickerView.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    
    pickerView.hidden=YES;
    
    // picker init end
    
    // catch data start
   
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Time" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    
    
    if(contextlist.count==0)
    {
        if(start_hour==nil)
        {
            start_hour=@"00";
            start_min=@"01";
        }
        
        NSManagedObject *newtime = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newtime setValue:start_hour forKey:@"start_hour"];
        [newtime setValue:start_min forKey:@"start_min"];
        
        [context save:&error];
        NSLog(@"New save");
    }
    else
    {
        contextlist = [context executeFetchRequest:request error:&error];
        model = [contextlist objectAtIndex:0];
        
        start_hour=[model valueForKey:@"start_hour"];
        start_min=[model valueForKey:@"start_min"];
        
    }

    // catch data end
    
    // 1 for min, 2 for hour
    
    // put data into picker start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    myNumber = [f numberFromString:[start_hour substringWithRange:NSMakeRange(0, 2)]];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:0 animated:YES ];
   // start_hour = [NSString stringWithFormat:@"%ld", (long)[myNumber integerValue]];
    
    myNumber = [f numberFromString:[start_min substringWithRange:NSMakeRange(0, 2)]];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:1 animated:YES];
  //  start_min = [NSString stringWithFormat:@"%ld", (long)[myNumber integerValue]];
    
    
    // put data into picker end
    
    [self show_number];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 2;
}

// 1 for min, 2 for hour, 3 for sec

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return [arrayDay2 count];
    }
    else
    {
        return [arrayDay count];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval)
    {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height > 568)
        {
            retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50, 216)];
        }
        else
        {
            retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50, 162)];
        }
    }
    
    retval.font = [UIFont systemFontOfSize:42];
    retval.textColor = [UIColor whiteColor];
    retval.text =  [arrayDay objectAtIndex:row];
    return retval;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component==0)
    {
        
        return [arrayDay2 objectAtIndex:row];
    }
    else
    {
        return [arrayDay objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component==0)
    {
        start_hour=[arrayDay2 objectAtIndex:row];
        NSLog(@"%@",start_min);
        NSLog(@"%@",start_hour);
    }
    else if(component==1)
    {
        start_min=[arrayDay objectAtIndex:row];
        NSLog(@"%@",start_min);
        NSLog(@"%@",start_hour);
    }
    [self save_view];
}

-(void)save_view
{
    // save to core data start
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Time" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    if(contextlist.count==0)
    {
        if(start_hour==nil)
        {
            start_hour=@"00";
            start_min=@"01";
        }
        
        NSManagedObject *newtime = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newtime setValue:start_hour forKey:@"start_hour"];
        [newtime setValue:start_min forKey:@"start_min"];
        
        [context save:&error];
        NSLog(@"Save");
    }
    else
    {
        contextlist = [context executeFetchRequest:request error:&error];
        model = [contextlist objectAtIndex:0];
        
        [model setValue:start_hour forKey:@"start_hour"];
        [model setValue:start_min forKey:@"start_min"];
        [context save:&error];
        
        NSLog(@"Save2");
    }
    // save to core data end
    
}
-(void)show_number
{
    show_time_label.text = [NSString stringWithFormat:@"%@ : %@",start_hour,start_min];
    show_time_label.textColor = [UIColor whiteColor];
}

-(void)pickerview_show_action:(id)sender
{
    if(pickerview_show==0)
    {
        show_time_label.text =@":   ";
        pickerView.hidden=NO;
        pickerview_show=1;
    }
    else
    {
        [self pickerview_disappear];
    }
    
   // [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(60, 153, 200, 200)];}];
    
   // [UIView animateWithDuration:0.6 animations:^{[self.cancel_btn setFrame:CGRectMake(541, 153, 200, 200)];}];
    
}

-(void)pickerview_disappear
{
    pickerview_show=0;
    pickerView.hidden=YES;
    [self show_number];

   // [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(60, 603, 200, 200)];}];
    
   // [UIView animateWithDuration:0.6 animations:^{[self.cancel_btn setFrame:CGRectMake(541, 684, 200, 200)];}];
    
}
-(void)summit_action:(id)sender
{
    if([[start_hour substringWithRange:NSMakeRange(0, 2)]isEqualToString:@"00"]&&[[start_min substringWithRange:NSMakeRange(0, 2)]isEqualToString:@"00"])
    {
       UIAlertView *alertview4 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                            message:NSLocalizedString(@"time_passed", nil)
                                            delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil ];
        alertview4.alertViewStyle = UIAlertViewStyleDefault;
        alertview4.tag = 4;
        [alertview4 show];
    }
    else
    {
    alert_msg = [NSString stringWithFormat:NSLocalizedString(@"stopwatch", nil), start_hour,start_min];
    
    alertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                           message:alert_msg
                                          delegate:self
                                 cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                 otherButtonTitles:NSLocalizedString(@"OK", nil),nil ];
    alertview.alertViewStyle = UIAlertViewStyleDefault;
    alertview.tag = 1;
    
    [alertview show];
    }
    
    [self pickerview_disappear];
    
}
-(void)cancel_action:(id)sender
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    alertview3 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                            message:NSLocalizedString(@"cancel_notify", nil)                                           delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil ];
    alertview3.alertViewStyle = UIAlertViewStyleDefault;
    alertview3.tag = 3;
    
    [alertview3 show];
    [self pickerview_disappear];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1 && buttonIndex ==1)
    {
        [self.activityIndicatorView startAnimating];

        alertview5 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"waiting", nil)
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil ];
        alertview5.alertViewStyle = UIAlertViewStyleDefault;
        alertview5.tag = 5;
        
        [alertview5 show];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(set_time) userInfo:nil repeats:NO];
        
        //[self set_time];

    }
}

-(void)set_time
{
    // set start time and end time start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    alltime = [NSNumber numberWithLong:(([[f numberFromString:start_hour] integerValue] * 60 * 60) + ([[f numberFromString:start_min] integerValue] * 60))];
    
    start_time = [NSDate date];
    end_time = [NSDate dateWithTimeIntervalSinceNow: +([alltime integerValue])];
    NSTimeInterval timeBetweenInterval = [end_time timeIntervalSinceDate:start_time];
    during = [NSNumber numberWithDouble:timeBetweenInterval];
    
    // set start time and end time end
    
    NSLog(@"Time Set");
    [self trans_time];
}

-(void)trans_time
{
    // trans time start
    
    NSNumber  *myNumber2 = [NSNumber numberWithInteger: [during integerValue]];
    NSUInteger seconds = [myNumber2 integerValue];
    NSUInteger minutes = seconds/60;
    NSUInteger hours = minutes/60;
    long temp_long = (minutes%60);
    
    during_msg = [NSString stringWithFormat:NSLocalizedString(@"time", nil), (unsigned long)hours, temp_long];
    // trans time end
    
    NSLog(@"during_msg Set");
    [self save_to_coredata];
}

-(void)save_to_coredata
{
    // save to coredata start
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    
    NSManagedObject *newlog = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    [newlog setValue:start_time forKey:@"start_time"];
    [newlog setValue:end_time forKey:@"end_time"];
    [newlog setValue:during forKey:@"during"];
    [newlog setValue:during_msg forKey:@"during_msg"];
    
    [context save:&error];
    
    // save to coredata end
    
    NSLog(@"save log");
    [self notification_set];
    
    PFObject *log_pfobj = [PFObject objectWithClassName:@"TimeSettings"];
    log_pfobj[@"start_time"] = start_time;
    log_pfobj[@"during_msg"] = during_msg;
    [log_pfobj saveEventually];
    
}
-(void)notification_set
{
    
    NSTimeInterval timeBetweenInterval = [end_time timeIntervalSinceDate:start_time];
    during = [NSNumber numberWithDouble:timeBetweenInterval];
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate=end_time;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    notification.hasAction = YES;
    notification.alertBody = NSLocalizedString(@"rest", nil);
    notification.repeatCalendar = [NSCalendar currentCalendar];
    notification.repeatInterval = NSYearCalendarUnit;
    
    notification.alertAction = NSLocalizedString(@"OK", nil);
    notification.soundName = UILocalNotificationDefaultSoundName;
    //notification.applicationIconBadgeNumber=1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    for (int i=1; i<200; i++)
    {
        notification.fireDate= [NSDate dateWithTimeIntervalSinceNow: +([alltime integerValue])+(i/40)];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }

    [self.activityIndicatorView stopAnimating];
    
    NSLog(@"Notification Set");
    
    alertview2 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                            message:NSLocalizedString(@"done", nil)
                                           delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil ];
    alertview2.alertViewStyle = UIAlertViewStyleDefault;
    alertview2.tag = 2;
    
    [alertview2 show];
    [alertview5 dismissWithClickedButtonIndex:0 animated:1];

    
    //[self requestPasscode];
}



//點擊文字框以外的地方隱藏鍵盤

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self pickerview_disappear];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
