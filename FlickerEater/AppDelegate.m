//
//  AppDelegate.m
//  FlickerEater
//
//  Created by Gonzalo Erro on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "AppDelegate.h"

#import "MainListViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.viewController = [[MainListViewController alloc] initWithNibName:@"MainListViewController_iPhone"
                                                                   bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
