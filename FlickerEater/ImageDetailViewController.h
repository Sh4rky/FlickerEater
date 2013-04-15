//
//  ImageDetailViewController.h
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Photo.h"

@interface ImageDetailViewController : UIViewController

@property (nonatomic, retain)Photo *photo;

@property (nonatomic, retain)IBOutlet AsyncImageView *fullImage;
@property (nonatomic, retain)IBOutlet UILabel *usernameLabel;
@property (nonatomic, retain)IBOutlet UILabel *titleLabel;

@end
