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
#import "Photo.h"

NSString *const kGalleryTitle = @"Photo Gallery";
NSString *const kFlickerUrl = @"http://api.flickr.com/services/feeds/photos_public.gne";

NSInteger const kAsyncImageViewTag = 2012040719;
NSInteger const kBlackBackgroundViewTag = 2012040720;
NSInteger const kImageFrameThickness = 5;

@interface MainListViewController ()

@property (nonatomic, retain)NSMutableArray *imagesData;
@property (nonatomic, retain)NSXMLParser *parser;
@property (nonatomic, retain)NSString *completeURL;

- (void)downloadDataWithParameter:(NSString *)parameters;
- (void)downloadDefaultData;

@end

@implementation MainListViewController

//Public
@synthesize imagesCollection = _imagesCollection;
@synthesize searchBar = _searchBar;

//Private
@synthesize imagesData = _imagesData;
@synthesize parser = _parser;
@synthesize completeURL = _completeURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(kGalleryTitle, nil);
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    [self.imagesCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrImageCell"];

    [self downloadDefaultData];
}

#pragma mark - Private Method

- (void)downloadDataWithParameter:(NSString *)parameters {
    
    self.completeURL = kFlickerUrl;
    
    if ([parameters length] > 0) {
        self.completeURL = [NSString stringWithFormat:@"%@%@", kFlickerUrl, parameters];
    }
    
    [self downloadDefaultData];
}

- (void)downloadDefaultData {
    
    if (!_completeURL) {
        self.completeURL = kFlickerUrl;
    }
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:self.completeURL]];
    ASSERT(parser);
    self.parser = parser;
    
    FlickerParser *flickerParser = [[FlickerParser alloc] init];
    flickerParser.delegate = self;
    
    [_parser setDelegate:flickerParser];
    [_parser parse];
    
}

#pragma mark - UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imagesData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    Photo *photo = [self.imagesData objectAtIndex:indexPath.row];
    ASSERT_CLASS(photo, Photo);
    
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
    [asyncImageView setImageURL:[NSURL URLWithString:photo.url]];
    [asyncImageView setContentMode:UIViewContentModeScaleAspectFit];
    [asyncImageView setTag:kAsyncImageViewTag];
    
    UIView *blackBackground = [[UIView alloc] initWithFrame:frame];
    [blackBackground setBackgroundColor:[UIColor blackColor]];
    [blackBackground setTag:kBlackBackgroundViewTag];
    
    [cell.contentView addSubview:blackBackground];
    
    [cell.contentView addSubview:asyncImageView];
    
    return cell;
}

#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [self.imagesData objectAtIndex:indexPath.row];
    ASSERT_CLASS(photo, Photo);
    
    ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] initWithNibName:@"ImageDetailViewController" bundle:nil];
    [imageDetailVC setPhoto:photo];
    
    [self.navigationController pushViewController:imageDetailVC animated:YES];

}

#pragma mark - FlickerParserDelegate

- (void)flickerParserEnded:(NSMutableArray *)images {
    ASSERT_CLASS(images, NSMutableArray);
    
    self.imagesData = images;
    
    [self.imagesCollection reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [_parser abortParsing];
    
    self.parser = nil;
    self.imagesData = nil;
    
    [self.imagesCollection reloadData];
    
    [self downloadDataWithParameter:[NSString stringWithFormat:@"?tags=%@", searchBar.text]];
    
    [searchBar resignFirstResponder];
}


@end
