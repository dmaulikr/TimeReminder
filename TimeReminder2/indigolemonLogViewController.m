//
//  indigolemonLogViewController.m
//  TR
//
//  Created by Jim Lai on 2014/3/12.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonLogViewController.h"
#import "indigolemonDetailViewController.h"

@interface indigolemonLogViewController ()
{
    NSManagedObjectContext *context;
    NSArray *contextlist;
    NSArray *start_time;
    NSArray *end_time;
    NSArray *during;
    NSArray *during_msg;
    SLComposeViewController *mySLComposerSheet;
    
    NSDate *start_time_temp;
    NSDate *end_time_temp;
    NSString *start_time_string;
    NSString *end_time_string;
    NSString *del_timezone;
    
    UIAlertView *alertview;
    UIAlertView *loginalertview2;

    
}
@end

@implementation indigolemonLogViewController

-(void) swipeRight:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        NSLog(@"swipe right");
    [self.tabBarController setSelectedIndex:1];
}

-(void) swipeLeft:(UISwipeGestureRecognizer *) recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
        NSLog(@"swipe left");
    [self.tabBarController setSelectedIndex:3];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];

    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log.jpg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"log.jpg"]];
    

    UIImage *email_img = [UIImage imageNamed:@"email2_bar.png"];
    UIBarButtonItem *emailButton = [[UIBarButtonItem alloc] initWithImage:email_img style:UIBarButtonItemStylePlain target:self action:@selector(email_check)];
    
    UIImage *fb_img = [UIImage imageNamed:@"fb.png"];
    UIBarButtonItem *fbButton = [[UIBarButtonItem alloc] initWithImage:fb_img style:UIBarButtonItemStylePlain target:self action:@selector(fb_check)];
    
    
    self.navigationItem.rightBarButtonItems = @[emailButton,fbButton];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    swipeLeft.delegate = self;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    swipeRight.delegate = self;
    
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;

    contextlist = [context executeFetchRequest:request error:&error];
    if (contextlist.count>0)
    {
        start_time = [contextlist valueForKey:@"start_time"];
        end_time = [contextlist valueForKey:@"end_time"];
        during = [contextlist valueForKey:@"during"];
        during_msg = [contextlist valueForKey:@"during_msg"];
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
   // self.title=@"歷史紀錄";
    indigolemonAppDelegate *appDelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSError *error;
    
    contextlist = [context executeFetchRequest:request error:&error];
    if (contextlist.count>0)
    {
        start_time = [contextlist valueForKey:@"start_time"];
        end_time = [contextlist valueForKey:@"end_time"];
        during = [contextlist valueForKey:@"during"];
        during_msg = [contextlist valueForKey:@"during_msg"];
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contextlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if(cell ==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }

    // Configure the cell...
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell.jpg"]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log.jpg"]];

    if(contextlist.count<=0)
    {
        NSLog(@"No Data");
    }
    else
    {
        during= [contextlist valueForKey:@"during"];
        
     //   cell.textLabel.text = [NSString stringWithFormat:@"%ld      使用時間：      %@",(long)([indexPath row]+1),[during_msg objectAtIndex:[indexPath row]]];

        UILabel * number_Label = (UILabel *) [cell viewWithTag:100];
        UILabel * time_Label = (UILabel *) [cell viewWithTag:200];
        UILabel * start_Label = (UILabel *) [cell viewWithTag:300];

        // correct start time type start

        start_time_temp = [[start_time objectAtIndex:[indexPath row]] dateByAddingTimeInterval: +28800];
        start_time_string = [NSString stringWithFormat:@"%@",start_time_temp];
        del_timezone = [start_time_string substringWithRange:NSMakeRange(0, 16)];

        // correct start time type end
        NSNumber *temp_long = [NSNumber numberWithLong:([indexPath row]+1)];
        number_Label.text = [NSString stringWithFormat:@"%@",temp_long];
        time_Label.text = [NSString stringWithFormat:@"%@",[during_msg objectAtIndex:[indexPath row]]];
        start_Label.text = [NSString stringWithFormat:@"%@",del_timezone];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"%ld %@",(long)[indexPath row],[during objectAtIndex:[indexPath row]]);
//    sendvalue = [NSNumber numberWithLong:(long)[indexPath row]];
   
    //[self performSegueWithIdentifier:@"logtodetail"sender:self];
}

// email start
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logtodetail"]) {
        indigolemonDetailViewController *detailVC = (indigolemonDetailViewController*)segue.destinationViewController;
        
        detailVC.title = [NSString stringWithFormat:@"%d", (int)([self.tableView indexPathForSelectedRow].row+1)];
        detailVC.passvalue = [self.tableView indexPathForSelectedRow].row;
    }
}

- (void)fb_check
{
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils initializeFacebook];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self shareonfb:@"http://www.facebook.com/TimeReminder/":@"TimeReminder+" ];
        } else {
            NSLog(@"User with facebook logged in!");
            [self shareonfb:@"http://www.facebook.com/TimeReminder/":@"TimeReminder+" ];
        }
    }];
}
-(void)shareonfb:(NSString*) current_URL :(NSString*) current_title
{
    
    NSURL* url = [NSURL URLWithString:current_URL];
    [FBDialogs presentShareDialogWithLink:url name:@"TimeReminder+" caption:@"TimeReminder+" description:@"TimeReminder+" picture:[NSURL URLWithString:@"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/10294384_475397789260321_347548610769222148_n.jpg"] clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error)
     {
         if(error)
         {
             NSLog(@"Error: %@", error.description);
         }
         else
         {
             NSLog(@"FB Success ");
             // parse start
             
             PFObject *uploadObject = [PFObject objectWithClassName:@"ShareOnFB"];
             uploadObject[@"title"]=current_title;
             uploadObject[@"url"]=current_URL;
             // [uploadObject saveEventually];
             
             // parse end
         }
     }];

}

-(void)email_check
{
if ([MFMailComposeViewController canSendMail])
// The device can send email.
{
    
    NSLog(@"E-mail Success!");
    [self display_email];        }
else
// The device can not send email.
{
    loginalertview2 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"email1", nil)
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                   otherButtonTitles:nil ];
    loginalertview2.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview2.tag = 1;
    [loginalertview2 show];
}
}

-(void)display_email
{
    
    if(contextlist.count==0)
    {
        alertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                               message:NSLocalizedString(@"norecord", nil)
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                     otherButtonTitles:nil ];
        alertview.alertViewStyle = UIAlertViewStyleDefault;
        alertview.tag = 1;
        
        [alertview show];

    }
    else
    {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"TimeReminder+"];
	
	// Set up recipients
    
    
	//NSArray *toRecipients = [NSArray arrayWithObject:@"1"];
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"1", nil];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"1"];
	//[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
	
    
    
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	//NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
    
    NSString *emailBody = NSLocalizedString(@"email2", nil);
    for (int i = 0;i<during_msg.count;i++)
    {
        // trans to +8000 start
        
        start_time_temp = [[start_time objectAtIndex:i] dateByAddingTimeInterval: +28800];
        end_time_temp= [[end_time objectAtIndex:i] dateByAddingTimeInterval: +28800];
        
        // trans to +8000 end
        
        // del +0000 start
        
        start_time_string = [NSString stringWithFormat:@"%@",start_time_temp];
        del_timezone = [start_time_string substringWithRange:NSMakeRange(0, 16)];
        NSString *start_time_trans = del_timezone;
        
        end_time_string = [NSString stringWithFormat:@"%@",end_time_temp];
        del_timezone = [end_time_string substringWithRange:NSMakeRange(0, 16)];
         NSString *end_time_trans = del_timezone;
        
        // del +0000 end
        
        emailBody = [NSString stringWithFormat:@"%@ \n %d         %@            %@          %@",emailBody,(i+1),[during_msg objectAtIndex:i],start_time_trans,end_time_trans];
    }
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: Mail sending canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: Mail saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: Mail sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Result: Mail sending failed");
			break;
		default:
			NSLog(@"Result: Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

// email end

// delete start

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
        
        [self setEditing:NO animated:YES];
        
        indigolemonAppDelegate *appdelegate = (indigolemonAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSError *error;
        [context deleteObject:[contextlist objectAtIndex:[indexPath row]]];
        
        [context save:&error];
        NSLog(@"Log Deleted");
        
        
        context = [appdelegate managedObjectContext];
        NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
        
        NSFetchRequest *request =[[NSFetchRequest alloc] init];
        [request setEntity:entitydesc];
        contextlist = [context executeFetchRequest:request error:&error];
        [tableView reloadData];
        
    }
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //  self.tableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}

// delete end

@end
