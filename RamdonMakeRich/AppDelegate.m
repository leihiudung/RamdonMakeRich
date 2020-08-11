//
//  AppDelegate.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/7/30.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "AppDelegate.h"
#import "TAVTabBarControllerConfig.h"

@interface AppDelegate ()
//@property (nonatomic, strong) UIWindow *windows;

@end

@implementation AppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    TAVTabBarControllerConfig *controllerConfig = [[TAVTabBarControllerConfig alloc]init];

    [self.window setRootViewController:[controllerConfig tabBarController]];
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
