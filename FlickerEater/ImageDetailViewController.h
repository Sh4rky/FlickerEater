//
//  ImageDetailViewController.h
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ImageDetailViewController : UIViewController

@property (nonatomic, retain)NSURL *imageURL;
@property (nonatomic, retain)IBOutlet AsyncImageView *fullImage;

@end
