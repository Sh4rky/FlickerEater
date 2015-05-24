//
//  ImageDetailViewController.m
//  FlickerEater
//
//  Created by Gonzalo G Erro on 5/22/15.
//  Copyright (c) 2015 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kiwi.h"
#import "ImageDetailViewController.h"
#import "MainListViewController.h"

SPEC_BEGIN(ImageDetailViewControllerTest)

describe(@"Image Details View Controller", ^{
    context(@"when created without photo property set", ^{
        
        __block ImageDetailViewController *detailsViewController;
        
        beforeEach(^{
            detailsViewController = [[ImageDetailViewController alloc] initWithNibName:@"ImageDetailViewController" bundle:nil];
            UIView *view = detailsViewController.view;
            
            view = nil;
        });
        
        it(@"is not nil", ^{
            [[detailsViewController shouldNot] beNil];
        });
        it(@"has a view", ^{
            [[theValue(detailsViewController.view) shouldNot] beNil];
        });
        
        it(@"should have an image view", ^{
            
            UIImageView *fullImageView = (UIImageView *)[detailsViewController fullImage];
            [[fullImageView shouldNot] beNil];
        });
        
        it(@"should have an image view as wide as view controllers view", ^{
            
            UIImageView *fullImageView = (UIImageView *)[detailsViewController fullImage];
            
            CGFloat width = detailsViewController.view.frame.size.width;
            
            [[theValue(fullImageView.frame.size.width) should] equal:theValue(width)];
        });
        
        it(@"should have an image view as height as view controllers view", ^{
            
            UIImageView *fullImageView = (UIImageView *)[detailsViewController fullImage];
            
            CGFloat height = detailsViewController.view.frame.size.height;
            
            [[theValue(fullImageView.frame.size.height) should] equal:theValue(height)];
        });
        
        it(@"should load ImageView IBOutlet", ^{
            
            [[theValue(detailsViewController.fullImage) shouldNot] beNil];
        });
        
        it(@"should load UILabel username IBOutlet", ^{
            
            [[theValue(detailsViewController.usernameLabel) shouldNot] beNil];
        });
        
        it(@"should load UILabel title IBOutlet", ^{
            
            [[theValue(detailsViewController.title) shouldNot] beNil];
        });
        
        it(@"shouldn't have any image url", ^{
            [[detailsViewController.fullImage.imageURL should] beNil];
        });
        
        afterAll(^{
            detailsViewController = nil;
        });
    });
    
    context(@"when created with photo property seted", ^{
        
        __block ImageDetailViewController *detailsViewController;
        
        beforeEach(^{
            detailsViewController = [[ImageDetailViewController alloc] initWithNibName:@"ImageDetailViewController" bundle:nil];
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            
            NSString *photoMockPath = [bundle pathForResource:@"photoEntityMock" ofType:@"plist"];
            
            NSDictionary *photoDicMock = [NSDictionary dictionaryWithContentsOfFile:photoMockPath];
            
            Photo *mockedPhoto = [[Photo alloc] init];
            
            mockedPhoto.username = [photoDicMock objectForKey:@"username"];
            mockedPhoto.title = [photoDicMock objectForKey:@"title"];
            mockedPhoto.url = [photoDicMock objectForKey:@"url"];
            
            detailsViewController.photo = mockedPhoto;
            
            UIView *view = detailsViewController.view;
            
            view = nil;
        });
        
        it(@"is not nil", ^{
            [[detailsViewController shouldNot] beNil];
        });
        it(@"has a view", ^{
            [[theValue(detailsViewController.view) shouldNot] beNil];
        });
        
        it(@"should have an image view", ^{
            
            UIImageView *fullImageView = (UIImageView *)[detailsViewController fullImage];
            [[fullImageView shouldNot] beNil];
        });
        
        it(@"should have image url", ^{
            [[detailsViewController.fullImage.imageURL shouldEventually] beNonNil];
        });
        
        it(@"should haved username text", ^{
            [[detailsViewController.usernameLabel.text shouldNot] beNil];
        });

        it(@"should haved title text", ^{
            [[detailsViewController.titleLabel.text shouldNot] beNil];
        });

        it(@"should go back to main", ^{
            
            UINavigationController *navVC = detailsViewController.navigationController;
            
            [navVC popViewControllerAnimated:NO];
            
            UIViewController *topViewController = navVC.topViewController;
            
            [[topViewController shouldEventually]beKindOfClass:[MainListViewController class]];
        });
        
        afterAll(^{
            detailsViewController = nil;
        });
    });

});


SPEC_END
