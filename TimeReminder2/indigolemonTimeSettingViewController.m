//
//  indigolemonTimeSettingViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonTimeSettingViewController.h"

@interface indigolemonTimeSettingViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSManagedObjectContext *context2;
    NSArray *contextlist2;
    NSArray *print;
    UIAlertView *alertview;
    UIAlertView *alertview2;
    UIAlertView *alertview3;
    NSString *alert_msg;
    NSString *start_hour;
    NSString *start_min;
    NSString *start_sec;
    NSNumber *alltime;
    NSDate *start_time;
    NSDate *end_time;
    NSDate *now;
    NSNumber *during;
    NSNumberFormatter * f;
    NSTimer *timer;
    NSString *during_msg;
    int alert_num;
}
@end

@implementation indigolemonTimeSettingViewController
@synthesize start_hour_label;
@synthesize start_min_label;
@synthesize start_sec_label;
@synthesize summit_btn;
@synthesize cancel_btn;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    self.title=@"StopWatch";
    
    //add start
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
            start_min=@"00";
            start_sec=@"05";
        }
        
        NSManagedObject *newtime = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newtime setValue:start_hour forKey:@"start_hour"];
        [newtime setValue:start_min forKey:@"start_min"];
        [newtime setValue:start_sec forKey:@"start_sec"];
        
        [context save:&error];
        NSLog(@"New");
    }
    else
    {
        contextlist = [context executeFetchRequest:request error:&error];
        print = [contextlist objectAtIndex:0];
        
        start_hour=[print valueForKey:@"start_hour"];
        start_min=[print valueForKey:@"start_min"];
        start_sec=[print valueForKey:@"start_sec"];
        
    }
    //add end
    
    start_hour_label.text=start_hour;
    start_min_label.text=start_min;
    start_sec_label.text=start_sec;
    



}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"time.jpg"]];
    UIImage *summit_img = [UIImage imageNamed:@"play.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];
    
	//add start
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
            start_min=@"00";
            start_sec=@"05";
        }
        
        NSManagedObject *newtime = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newtime setValue:start_hour forKey:@"start_hour"];
        [newtime setValue:start_min forKey:@"start_min"];
        [newtime setValue:start_sec forKey:@"start_sec"];
        
        [context save:&error];
        NSLog(@"New");
    }
    else
    {
        contextlist = [context executeFetchRequest:request error:&error];
        print = [contextlist objectAtIndex:0];
        
        start_hour=[print valueForKey:@"start_hour"];
        start_min=[print valueForKey:@"start_min"];
        start_sec=[print valueForKey:@"start_sec"];
        
    }
    //add end
    
    start_hour_label.text=start_hour;
    start_min_label.text=start_min;
    start_sec_label.text=start_sec;

    
}

-(void)summit_action:(id)sender
{
    alert_num=1;
    alert_msg = [NSString stringWithFormat:@"請問您是否要在%@小時%@分鐘%@秒後，讓您的小朋友不能使用iPad？", start_hour,start_min,start_sec];
    
    alertview = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:alert_msg
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"確定",nil ];
    alertview.alertViewStyle = UIAlertViewStyleDefault;
    alertview.tag = 1;

    [alertview show];
    
}
-(void)cancel_action:(id)sender
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    alert_num=3;
    alertview3 = [[UIAlertView alloc] initWithTitle:@"提示"
                                            message:@"已取消所有通知。"
                                           delegate:self
                                  cancelButtonTitle:@"確定"
                                  otherButtonTitles:nil ];
    alertview3.alertViewStyle = UIAlertViewStyleDefault;
    alertview3.tag = 1;
    
    [alertview3 show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1 && buttonIndex ==1)
    {
        [self set_time];
        alert_num=2;
        alertview2 = [[UIAlertView alloc] initWithTitle:@"提示"
                                               message:@"已設定完成。"
                                              delegate:self
                                     cancelButtonTitle:@"確定"
                                     otherButtonTitles:nil ];
        alertview2.alertViewStyle = UIAlertViewStyleDefault;
        alertview2.tag = 1;
        
        [alertview2 show];
    }
}
-(void)set_time
{
    // re catch start

    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Time" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    print = [contextlist objectAtIndex:0];
    
    start_hour=[print valueForKey:@"start_hour"];
    start_min=[print valueForKey:@"start_min"];
    start_sec=[print valueForKey:@"start_sec"];

    
    // re catch end

    // set start time and end time start
    
    f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    alltime = [NSNumber numberWithLong:(([[f numberFromString:start_hour] integerValue] * 60 * 60) + ([[f numberFromString:start_min] integerValue] * 60) + ([[f numberFromString:start_sec] integerValue]))];
    
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
    
    NSNumber  *myNumber = [NSNumber numberWithInteger: [during integerValue]];
    NSUInteger seconds = [myNumber integerValue];
    NSUInteger minutes = seconds/60;
    NSUInteger hours = minutes/60;
    
during_msg = [NSString stringWithFormat:@"%02lu 小時 %02lu 分 %02lu 秒", (unsigned long)hours, minutes%60, seconds%60];
    // trans time end
    
    NSLog(@"during_msg Set");
    [self save_to_coredata];
    NSLog(@"st_hr :%@",start_hour);
    NSLog(@"st_min :%@",start_min);
    NSLog(@"st_sec :%@",start_sec);
    NSLog(@"all :%@",alltime);
    NSLog(@"end :%@",end_time);
    NSLog(@"during :%@",during);
    NSLog(@"during_msg :%@",during_msg);
}

-(void)save_to_coredata
{
    // save to coredata start
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context2 = [appDelegate managedObjectContext];
    NSEntityDescription *entitydesc2 = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context2];
    NSFetchRequest *request2 =[[NSFetchRequest alloc] init];
    [request2 setEntity:entitydesc2];
    NSError *error;
    
    NSManagedObject *newlog = [[NSManagedObject alloc]initWithEntity:entitydesc2 insertIntoManagedObjectContext:context2];
    [newlog setValue:start_time forKey:@"start_time"];
    [newlog setValue:end_time forKey:@"end_time"];
    [newlog setValue:during forKey:@"during"];
    [newlog setValue:during_msg forKey:@"during_msg"];
    
    [context2 save:&error];
    
    // save to coredata end
    
    NSLog(@"save log");
    [self notification_set];
}
-(void)notification_set
{
    
    NSTimeInterval timeBetweenInterval = [end_time timeIntervalSinceDate:start_time];
    during = [NSNumber numberWithDouble:timeBetweenInterval];

    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate=end_time;
    notification.repeatInterval=1;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    notification.hasAction = YES;
    notification.alertBody = @"該休息了，請將iPad交給你的父母親。";
    notification.repeatCalendar = [NSCalendar currentCalendar];
    notification.repeatInterval = NSMinuteCalendarUnit;
    
    notification.alertAction = @"確定";
    notification.soundName = UILocalNotificationDefaultSoundName;
    //notification.applicationIconBadgeNumber=1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    for (int i=1; i<100; i++)
    {
        notification.fireDate= [NSDate dateWithTimeIntervalSinceNow: +([alltime integerValue])+(i/20)];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    NSLog(@"Notification Set");
    
    //[self requestPasscode];
}

-(void)requestPasscode
{
    [self performSegueWithIdentifier:@"gotopassword" sender:self];
    NSLog(@"gotopassword");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
