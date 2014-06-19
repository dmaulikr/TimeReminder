//
//  indigolemonPickerViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonPickerViewController.h"

@interface indigolemonPickerViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSNumber *myNumber;
    UIAlertView *alertview;
}
@end

@implementation indigolemonPickerViewController
@synthesize pickerView;

@synthesize arrayDay;
@synthesize arrayDay2;

@synthesize start_hour;
@synthesize start_min;
@synthesize start_sec;
@synthesize model;
@synthesize summit_btn;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
   // self.title=@"時間設定";
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"time.jpg"]];
    
    
    UIImage *summit_img = [UIImage imageNamed:@"save2.png"];
    [summit_btn setBackgroundImage:summit_img forState:UIControlStateNormal];

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
    pickerView.transform = CGAffineTransformMakeScale(2, 2);
    
    // picker init end

    // catch data start
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Time" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    model = [contextlist objectAtIndex:0];
    
    start_hour = [model valueForKey:@"start_hour"];
    start_min = [model valueForKey:@"start_min"];
    start_sec = [model valueForKey:@"start_sec"];
    
    
    // catch data end

    // 1 for min, 2 for hour, 3 for sec
    
    // put data into picker start
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    myNumber = [f numberFromString:start_hour];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:0 animated:YES ];
    
    myNumber = [f numberFromString:start_min];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:1 animated:YES];
    
    myNumber = [f numberFromString:start_sec];
    [pickerView reloadAllComponents];
    [pickerView selectRow:[myNumber integerValue] inComponent:2 animated:YES];
    
    // put data into picker end
}

-(void)donebtn:(id)sender
{
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Time" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    contextlist = [context executeFetchRequest:request error:&error];
    model = [contextlist objectAtIndex:0];
    
    [self.model setValue:start_hour forKey:@"start_hour"];
    [self.model setValue:start_min forKey:@"start_min"];
    [self.model setValue:start_sec forKey:@"start_sec"];
    
    [context save:&error];
    NSLog(@"Save!");

    alertview = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"已儲存"
                                          delegate:self
                                 cancelButtonTitle:@"確定"
                                 otherButtonTitles:nil ];
    alertview.alertViewStyle = UIAlertViewStyleDefault;
    alertview.tag = 1;
    
    [alertview show];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 3;
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
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50, 216)];
    }
    
    retval.font = [UIFont systemFontOfSize:42];
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
    else if(component==2)
    {
        start_sec=[arrayDay objectAtIndex:row];
        NSLog(@"%@",start_sec);
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
