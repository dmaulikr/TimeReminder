//
//  indigolemonDetailViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonDetailViewController.h"

@interface indigolemonDetailViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSArray *start_time;
    NSArray *end_time;
    NSArray *during;
    NSArray *during_msg;
    NSDate *start_time_temp;
    NSDate *end_time_temp;
    NSString *start_time_string;
    NSString *end_time_string;
    NSString *del_timezone;
}
@end

@implementation indigolemonDetailViewController

@synthesize during_label;
@synthesize start_time_label;
@synthesize end_time_label;
@synthesize passvalue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{

    //self.title = @"詳細內容";
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    
    start_time = [contextlist valueForKey:@"start_time"];
    end_time = [contextlist valueForKey:@"end_time"];
    during_msg = [contextlist valueForKey:@"during_msg"];

    // trans to +8000 start
    
    start_time_temp = [[start_time objectAtIndex:self.passvalue] dateByAddingTimeInterval: +28800];
    end_time_temp= [[end_time objectAtIndex:self.passvalue] dateByAddingTimeInterval: +28800];
    
    // trans to +8000 end
    
    // del +0000 start
    
    start_time_string = [NSString stringWithFormat:@"%@",start_time_temp];
    del_timezone = [start_time_string substringWithRange:NSMakeRange(0, 16)];
    start_time_label.text = del_timezone;
    
    end_time_string = [NSString stringWithFormat:@"%@",end_time_temp];
    del_timezone = [end_time_string substringWithRange:NSMakeRange(0, 16)];
    end_time_label.text = del_timezone;
    
    // del +0000 end
    
    during_label.text = [during_msg objectAtIndex:self.passvalue];
    
    during_label.textColor=[UIColor whiteColor];
    start_time_label.textColor=[UIColor whiteColor];
    end_time_label.textColor=[UIColor whiteColor];
    
    
    NSLog(@"pass value: %d", (int)self.passvalue);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detail024.jpg"]];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
