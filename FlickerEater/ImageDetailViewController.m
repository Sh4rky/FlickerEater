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

@synthesize photo = _photo;

@synthesize fullImage = _fullImage;
@synthesize usernameLabel = _usernameLabel;
@synthesize titleLabel = _titleLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if ( (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) ) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(kPhotoDetailTitle, nil);
    [self.navigationController.navigationBar setBarStyle: UIBarStyleBlack];
    
    [self.fullImage setImageURL:[NSURL URLWithString:self.photo.url]];
    [self.usernameLabel setText:self.photo.username];
    [self.titleLabel setText:self.photo.title];
}


@end
