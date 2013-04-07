//
//  ViewController.m
//  FlickerEater
//
//  Created by Gonzalo Erro on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "MainListViewController.h"
#import "ImageDetailViewController.h"
#import "AsyncImageView.h"

NSString *const kGalleryTitle = @"Photo Gallery";
NSString *const kFlickerUrl = @"http://api.flickr.com/services/feeds/photos_public.gne";

NSInteger const kAsyncImageViewTag = 2012040719;
NSInteger const kBlackBackgroundViewTag = 2012040720;
NSInteger const kImageFrameThickness = 5;

@interface MainListViewController ()

@property (nonatomic, retain)NSMutableArray *imagesData;

@end

@implementation MainListViewController

//Public
@synthesize imagesCollection = _imagesCollection;

//Private
@synthesize imagesData = _imagesData;

- (void)dealloc {
    [super dealloc];
    
    [_imagesData release];
    
    [_imagesCollection release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = NSLocalizedString(kGalleryTitle, nil);
    [self.navigationController.navigationBar setBarStyle: UIBarStyleBlack];
    
    [self.imagesCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrImageCell"];

    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:kFlickerUrl]];
    ASSERT(parser);
    
    FlickerParser *flickerParser = [[[FlickerParser alloc] init] autorelease];
    flickerParser.delegate = self;
    
    [parser setDelegate:flickerParser];
    [parser parse];
    [parser autorelease];
}

#pragma mark - UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imagesData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *stringURL = [self.imagesData objectAtIndex:indexPath.row];
    ASSERT_CLASS(stringURL, NSString);
    
    //Cleaning Content View
    [[cell.contentView viewWithTag:kAsyncImageViewTag] removeFromSuperview];
    [[cell.contentView viewWithTag:kBlackBackgroundViewTag] removeFromSuperview];
    
    //Drawing a White Frame
    CGRect frame = cell.contentView.frame;
    frame.origin.x = frame.origin.x + kImageFrameThickness;
    frame.origin.y = frame.origin.y + kImageFrameThickness;
    frame.size.width = frame.size.width - kImageFrameThickness * 2;
    frame.size.height = frame.size.height - kImageFrameThickness * 2;
    
    //Creating Image View and downloding it from Flicker
    AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:frame];
    [asyncImageView setActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [asyncImageView setImageURL:[NSURL URLWithString:stringURL]];
    [asyncImageView setContentMode:UIViewContentModeScaleAspectFit];
    [asyncImageView setTag:kAsyncImageViewTag];
    
    
    UIView *blackBackground = [[UIView alloc] initWithFrame:frame];
    [blackBackground setBackgroundColor:[UIColor blackColor]];
    [blackBackground setTag:kBlackBackgroundViewTag];
    
    [cell.contentView addSubview:blackBackground];
    [blackBackground release];
    
    [cell.contentView addSubview:asyncImageView];
    [asyncImageView release];
    
    return cell;
}

#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *stringURL = [self.imagesData objectAtIndex:indexPath.row];
    ASSERT_CLASS(stringURL, NSString);
    
    ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] initWithNibName:@"ImageDetailViewController" bundle:nil];
    [imageDetailVC setImageURL:[NSURL URLWithString:stringURL]];
    
    [self.navigationController pushViewController:imageDetailVC animated:YES];
    
    [imageDetailVC release];

}

#pragma mark - FlickerParserDelegate


- (void)flickerParserEnded:(NSMutableArray *)imagesUrls {
    ASSERT_CLASS(imagesUrls, NSMutableArray);
    
    self.imagesData = imagesUrls;
    
    [self.imagesCollection reloadData];
}

@end
