//
//  indigolemonDemoViewController.m
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/19.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonDemoViewController.h"

@interface indigolemonDemoViewController ()
{
    UIAlertView *loginalertview;
}
@end

@implementation indigolemonDemoViewController
@synthesize pageTitles;
@synthesize pageImages;
@synthesize parentViewController;
@synthesize demototutorial_btn;
@synthesize back_brn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad02.jpg"]];
    [self show_segue];
    demototutorial_btn.hidden=YES;
}

-(void)show_segue
{
    // Create the data model
    
    pageTitles = @[@"0.歡迎使用TimeReminder",@"1.完成設定說明", @"2.設定小朋友的使用時間", @"3.放心交給您的小朋友", @"4.時間到了，透過通知讓小朋友無法繼續使用", @"5.小朋友將iPad交還給您", @"6.按一下iPad「電源鍵」關閉銀幕，再按一下iPad「電源鍵」解鎖", @"7.開啓TimeReminder",@"8.查看歷史記錄",@"9.發送使用紀錄至您的E-Mail信箱", @"10.離開"];

    pageImages = @[@"00.png",@"01.png", @"02.png", @"03.png", @"04.png", @"05.png", @"06.png", @"07.png", @"08.png", @"09.png", @"10.png"];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height <= 568)
    {
        pageTitles = @[@"0.歡迎使用TimeReminder",@"1.完成設定說明", @"2.設定小朋友的使用時間", @"3.放心交給您的小朋友", @"4.時間到了，透過通知讓小朋友無法繼續使用", @"5.小朋友將iPad交還給您", @"6.按一下iPad「電源鍵」關閉銀幕，再按一下iPad「電源鍵」解鎖", @"7.開啓TimeReminder",@"8.查看歷史記錄",@"9.發送使用紀錄至您的E-Mail信箱", @"10.離開", @"11.png"];
        
        pageImages = @[@"00.png",@"01.png", @"02.png", @"03.png", @"04.png", @"05.png", @"06.png", @"07.png", @"08.png", @"09.png", @"10.png", @"11.png"];
    }
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    indigolemonPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller

    if (screenBounds.size.height > 568)
    {
        self.pageViewController.view.frame = CGRectMake(76.5, 87.3, 615, 830);
    }
    else
    {
        self.pageViewController.view.frame = CGRectMake(34.5, 70, 256, 624.4);
    }

    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(void)back_action:(id)sender
{
    
    loginalertview = [[UIAlertView alloc] initWithTitle:@"TimeReminder+"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                      otherButtonTitles:NSLocalizedString(@"recommend", nil),NSLocalizedString(@"start", nil),nil ];
    loginalertview.alertViewStyle = UIAlertViewStyleDefault;
    loginalertview.tag = 1;
    [loginalertview show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1 && buttonIndex ==1)
    {
        [self performSegueWithIdentifier:@"demototutorial"sender:self];
    }
    else if(alertView.tag==1 && buttonIndex ==2)
    {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((indigolemonPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((indigolemonPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (indigolemonPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    indigolemonPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
