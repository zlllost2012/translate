//
//  AppDelegate.m
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MobClick startWithAppkey:@"55f6d9c267e58ee487000970" reportPolicy:BATCH   channelId:@""];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    UighurController *ugc=[[UighurController alloc]init];
    ChineseController *cnc=[[ChineseController alloc]init];
    DictionaryController *dic=[[DictionaryController alloc]init];
    MoreController *moc=[[MoreController alloc]init];
    UINavigationController *ugcNav=[[UINavigationController alloc]initWithRootViewController:ugc];
    ugcNav.tabBarItem=[[UITabBarItem alloc]init];
    ugcNav.tabBarItem.title=@"维语";
    UINavigationController *cncNav=[[UINavigationController alloc]initWithRootViewController:cnc];
    cncNav.tabBarItem=[[UITabBarItem alloc]init];
    cncNav.tabBarItem.title=@"汉语";
    UINavigationController *dicNav=[[UINavigationController alloc]initWithRootViewController:dic];
    dicNav.tabBarItem=[[UITabBarItem alloc]init];
    dicNav.tabBarItem.title=@"字典";
    UINavigationController *mocNav=[[UINavigationController alloc]initWithRootViewController:moc];
    mocNav.tabBarItem=[[UITabBarItem alloc]init];
    mocNav.tabBarItem.title=@"更多";
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    NSArray *viewControllers=[[NSArray alloc]initWithObjects:ugcNav,cncNav,dicNav,mocNav, nil];
    [tabBarController setViewControllers:viewControllers animated:YES];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
