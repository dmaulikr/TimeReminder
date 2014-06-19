//
//  indigolemonTutorialViewController.m
//  TimeReminder2
//
//  Created by Jim Lai on 2014/3/19.
//  Copyright (c) 2014年 Jim Lai. All rights reserved.
//

#import "indigolemonTutorialViewController.h"

@interface indigolemonTutorialViewController ()

@end

@implementation indigolemonTutorialViewController
@synthesize pageTitles;
@synthesize pageImages;
@synthesize parentViewController;

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
}
-(void)show_segue
{
        // Create the data model
        
        pageTitles = @[@"1.設定/一般/密碼鎖定", @"2.設定您的密碼", @"3.設定/通知中心/TimeReminder", @"4.選擇「提示」", @"5.TimeReminder/其他/設定安全密碼",@"6.離開"];
    
        pageImages = @[@"1 copy.png", @"2 copy.png", @"3 copy.png", @"4 copy.png", @"5 copy.png", @"6 copy.png"];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height <= 568)
    {
        pageTitles = @[@"1.設定/一般/密碼鎖定", @"2.設定您的密碼", @"3.設定/通知中心/TimeReminder", @"4.選擇「提示」", @"5.TimeReminder/其他/設定安全密碼",@"6.離開", @"7 copy.png", @"8 copy.png", @"9 copy.png"];
        
        pageImages = @[@"1 copy.png", @"2 copy.png", @"3 copy.png", @"4 copy.png", @"5 copy.png", @"6 copy.png", @"7 copy.png", @"8 copy.png", @"9 copy.png"];
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
    [self dismissViewControllerAnimated:YES completion:^{}];
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
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
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
