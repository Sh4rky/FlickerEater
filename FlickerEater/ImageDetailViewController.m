//
//  ImageDetailViewController.m
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "ImageDetailViewController.h"

NSString *const kPhotoDetailTitle = @"Detail";

@interface ImageDetailViewController ()

@end

@implementation ImageDetailViewController

@synthesize imageURL = _imageURL;
@synthesize fullImage = _fullImage;

- (void)dealloc {
    [super dealloc];
    
    [_imageURL release];
    [_fullImage release];
}

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
    
    self.title = NSLocalizedString(kPhotoDetailTitle, nil);
    [self.navigationController.navigationBar setBarStyle: UIBarStyleBlack];
    
    [self.fullImage setImageURL:self.imageURL];
}


@end
