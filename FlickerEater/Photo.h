//
//  Entity.h
//  FlickerEater
//
//  Created by Gonzalo Erro on 4/14/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, retain)NSString *username;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *date;
@property (nonatomic, retain)NSString *url;

@end
