//
//  indigolemonClockViewController.m
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/18.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonClockViewController.h"

@interface indigolemonClockViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSNumber *myNumber;
    
    UIAlertView *alertview;
    UIAlertView *alertview2;
    UIAlertView *alertview3;
    UIAlertView *alertview4;
    UIAlertView *alertview5;
    UIAlertView *rating_alertview;

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

@implementation indigolemonClockViewController
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
-(void)viewWillDisappear:(BOOL)animated
{
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    
    contextlist = [context executeFetchRequest:request error:&error];
    if (contextlist.count==0)
    {
        [self.tabBarController setSelectedIndex:3];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    // self.title=@"定時器";
    
    // catch data start
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH-mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    NSLog(@"%@",resultString);
    
    // catch data end
    
    // put data into picker start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
    if([[resultString substringWithRange:NSMakeRange(0, 1)]isEqualToString:@"0"])
    {
        myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(1, 1)]];
        NSLog(@"%@",myNumber);

    }
    else
    {
        myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(0, 2)]];
        NSLog(@"%@",myNumber);


    }
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:0 animated:YES ];
    start_hour = [resultString substringWithRange:NSMakeRange(0, 2)];
    
    myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(3, 2)]];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:1 animated:YES];
    start_min = [resultString substringWithRange:NSMakeRange(3, 2)];
    
    // put data into picker end
    
    [self show_number];

    
}

-(void) swipeRight:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        NSLog(@"swipe right");
    [self.tabBarController setSelectedIndex:3];
}

-(void) swipeLeft:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
        NSLog(@"swipe left");
    [self.tabBarController setSelectedIndex:1];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // rating start
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger launchCount = [prefs integerForKey:@"launchCount"];
    if(launchCount==5)
    {
        rating_alertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                message:NSLocalizedString(@"rating1", nil)                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"rating2", nil)
                                      otherButtonTitles:NSLocalizedString(@"rating3", nil),NSLocalizedString(@"rating4", nil),nil ];
        rating_alertview.alertViewStyle = UIAlertViewStyleDefault;
        rating_alertview.tag = 6;
        
        [rating_alertview show];

    }
    // rating end
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clock3.jpg"]];
    
    
    UIImage *summit_img = [UIImage imageNamed:@"play.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    UIImage *cancel_img = [UIImage imageNamed:@"clock3_btn.png"];
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
    
    
    // picker init end
    
    // catch data start
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH-mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    NSLog(@"%@",resultString);
    
    // catch data end
    
    // 1 for min, 2 for hour
    
    // put data into picker start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if([[resultString substringWithRange:NSMakeRange(0, 1)]isEqualToString:@"0"])
    {
        myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(1, 1)]];
        NSLog(@"%@",myNumber);
    }
    else
    {
        myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(0, 2)]];
        NSLog(@"%@",myNumber);

        
    }
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:0 animated:YES ];
    start_hour = [resultString substringWithRange:NSMakeRange(0, 2)];
    
    myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(3, 2)]];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:1 animated:YES];
    start_min = [resultString substringWithRange:NSMakeRange(3, 2)];

    pickerView.hidden=YES;
    
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
        NSLog(@"%@",start_hour);
    }
    else if(component==1)
    {
        start_min=[arrayDay objectAtIndex:row];
        NSLog(@"%@",start_min);
    }
    
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
   // [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(290, 153, 200, 200)];}];
    
}
-(void)pickerview_disappear
{
    pickerview_show=0;
    pickerView.hidden=YES;
    [self show_number];
    
   // [UIView animateWithDuration:0.6 animations:^{[self.summit_btn setFrame:CGRectMake(290, 751, 200, 200)];}];

}
-(void)summit_action:(id)sender
{
    [self check];
    [self pickerview_disappear];

}
-(void)cancel_action:(id)sender
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    alertview3 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                            message:NSLocalizedString(@"cancel_notify", nil)
                                           delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil ];
    alertview3.alertViewStyle = UIAlertViewStyleDefault;
    alertview3.tag = 3;
    
    [alertview3 show];
    [self pickerview_disappear];

    
}

-(void)check
{
    // 防呆 找過去時間 start
    
    
    // catch data start
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH-mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    
    // catch data end
    
    // put data into picker start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
   // start_hour = [resultString substringWithRange:NSMakeRange(0, 2)];
    
    myNumber = [f numberFromString:[resultString substringWithRange:NSMakeRange(3, 2)]];
   // start_min = [NSString stringWithFormat:@"%ld", (long)[myNumber integerValue]];

    NSNumber *start_hour_num = [f numberFromString:start_hour];
    NSNumber *start_min_num = [f numberFromString:start_min];
    
    
    // put data into picker end
    
    // init start
    
    alertview4 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                        message:NSLocalizedString(@"time_passed", nil)
                                        delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil ];
    alertview4.alertViewStyle = UIAlertViewStyleDefault;
    alertview4.tag = 4;
    
    // init end
    
    
    if([start_hour_num integerValue]== [[f numberFromString:[resultString substringWithRange:NSMakeRange(0,2)]]integerValue])
    {
        if ([start_min_num integerValue]<= [[f numberFromString:[resultString substringWithRange:NSMakeRange(3, 2)]]integerValue]) {
            [alertview4 show];
        }
        else
        {
            alert_msg = [NSString stringWithFormat:NSLocalizedString(@"clock2", nil), start_hour,start_min];
            
            alertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                   message:alert_msg
                                                  delegate:self
                                         cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                         otherButtonTitles:NSLocalizedString(@"OK", nil),nil ];
            alertview.alertViewStyle = UIAlertViewStyleDefault;
            alertview.tag = 1;
            
            [alertview show];
        }
    }
    else if([start_hour_num integerValue]< [[f numberFromString:[resultString substringWithRange:NSMakeRange(0, 2)]]integerValue])
    {
        [alertview4 show];
    }
    else
    {
        
        alert_msg = [NSString stringWithFormat:NSLocalizedString(@"clock2", nil), start_hour,start_min];
        
        alertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                               message:alert_msg
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                     otherButtonTitles:NSLocalizedString(@"OK", nil),nil ];
        alertview.alertViewStyle = UIAlertViewStyleDefault;
        alertview.tag = 1;
        
        [alertview show];
    }
    // 防呆 找過去時間 end
    
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
    if(alertView.tag==6 && buttonIndex ==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/tw/app/timereminder+/id868624119?l=zh&mt=8"]];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSInteger launchCount = [prefs integerForKey:@"launchCount"];
        launchCount=11;
        [prefs setInteger:launchCount forKey:@"launchCount"];

    }
    else  if(alertView.tag==6 && buttonIndex ==2)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSInteger launchCount = [prefs integerForKey:@"launchCount"];
        launchCount=0;
        [prefs setInteger:launchCount forKey:@"launchCount"];
    }
}

-(void)set_time
{
    // set start time and end time start
    
    start_time = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *start_date_format = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];

    NSString *dateStr = [NSString stringWithFormat:@"%@%@%@00",[start_date_format substringWithRange:NSMakeRange(0, 8)],start_hour,start_min];
    
    // Convert string to date object
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyyMMddHHmmss"];
    end_time = [dateFormat2 dateFromString:dateStr];
    
    NSTimeInterval timeBetweenInterval = [end_time timeIntervalSinceDate:start_time];
    during = [NSNumber numberWithDouble:timeBetweenInterval];
    
    alltime = during;
    // set start time and end time end
    
    NSLog(@"Time Set");
    
    [self trans_time];

}

-(void)trans_time
{
    // trans time start
    
    NSNumber  *myNumber2 = [NSNumber numberWithInteger: [during integerValue]+59];
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
    
    [self.activityIndicatorView startAnimating];
    
    alertview2 = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                            message:NSLocalizedString(@"done",nil)                                         delegate:self
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
