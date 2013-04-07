//
//  AppDelegate.h
//  FlickerEater
//
//  Created by Gonzalo Erro on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainListViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navController;
@property (strong, nonatomic) MainListViewController *viewController;

@end
