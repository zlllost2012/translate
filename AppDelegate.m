//
//  AppDelegate.m
//  Translate
//
//  Created by zll on 15/9/11.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UILabel *timeLabel;
    int secondsCountDown;
    NSTimer *countDownTimer;
    MBProgressHUD *hud;
}
@end

@implementation AppDelegate
@synthesize adView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MobClick startWithAppkey:@"55f955b167e58e81fb002615" reportPolicy:BATCH   channelId:@""];
    secondsCountDown=3;
    //设置启动页面时间
    [NSThread sleepForTimeInterval:2.0];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //添加广告页
    adView=[[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.window.frame.size.width-80., 5., 80., 40.)];
    [timeLabel setText:@"剩余3s"];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setBackgroundColor:[UIColor blackColor]];
    [timeLabel setAlpha:0.8];
    [[SDImageCache sharedImageCache]clearDisk];
    hud=[MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.labelText=@"加载中...";
    UIImageView *adImageView=[[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [adView addSubview:adImageView];
    [adImageView sd_setImageWithURL:[NSURL URLWithString:AD_URL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [hud hide:YES];
        if (!error) {
            [adImageView setImage:image];
            [adView addSubview:timeLabel];
            countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }else{
            [self loadMainScreen];
        }
    }];
    [self.window addSubview:adView];
    [self.window bringSubviewToFront:adView];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)timeFireMethod{
    secondsCountDown--;
    NSString *s=[NSString stringWithFormat:@"剩余%ds",secondsCountDown];
    [timeLabel setText:s];
    if (secondsCountDown==0) {
        [countDownTimer invalidate];
        [adView removeFromSuperview];
        [self loadMainScreen];
    }
}
-(void)loadMainScreen{
    //设置主页面
    UighurController *ugc=[[UighurController alloc]init];
    ChineseController *cnc=[[ChineseController alloc]init];
    DictionaryController *dic=[[DictionaryController alloc]init];
    HistoryController *hic=[[HistoryController alloc]init];
    //    MoreController *moc=[[MoreController alloc]init];
    CustomNavigationController *ugcNav=[[CustomNavigationController alloc]initWithRootViewController:ugc];
    ugcNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"维语学习" image:[UIImage imageNamed:@"wstudy.png"] selectedImage:[UIImage imageNamed:@"wstudy_u.png"]];
    CustomNavigationController *cncNav=[[CustomNavigationController alloc]initWithRootViewController:cnc];
    cncNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"汉语学习" image:[UIImage imageNamed:@"hstudy.png"] selectedImage:[UIImage imageNamed:@"hstudy_u.png"]];
    CustomNavigationController *dicNav=[[CustomNavigationController alloc]initWithRootViewController:dic];
    dicNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"汉维字典" image:[UIImage imageNamed:@"dic.png"] selectedImage:[UIImage imageNamed:@"dic_u.png"]];
    CustomNavigationController *hicNav=[[CustomNavigationController alloc]initWithRootViewController:hic];
    hicNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"学习记录" image:[UIImage imageNamed:@"rec.png"] selectedImage:[UIImage imageNamed:@"rec_u.png"]];
    //    CustomNavigationController *mocNav=[[CustomNavigationController alloc]initWithRootViewController:moc];
    //    mocNav.tabBarItem=[[UITabBarItem alloc]init];
    //    mocNav.tabBarItem.title=@"更多";
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    tabBarController.tabBar.tintColor=[UIColor redColor];
    tabBarController.tabBar.barTintColor=[UIColor whiteColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    //    backView.backgroundColor = [UIColor colorWithRed:204./255. green:1./255. blue:1./255. alpha:1.f];
    [tabBarController.tabBar insertSubview:backView atIndex:0];
    tabBarController.tabBar.opaque = YES;
    
    NSArray *viewControllers=[[NSArray alloc]initWithObjects:ugcNav,cncNav,dicNav,hicNav, nil];
    [tabBarController setViewControllers:viewControllers animated:YES];
    [self.window setRootViewController:tabBarController];
    
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
