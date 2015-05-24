//
//  MainListViewControllerTest.m
//  FlickerEater
//
//  Created by Gonzalo G Erro on 5/22/15.
//  Copyright (c) 2015 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kiwi.h"
#import "MainListViewController.h"
#import "ImageDetailViewController.h"

SPEC_BEGIN(MainListViewControllerTest)

describe(@"Parsing XML", ^{
    context(@"when created", ^{
        
        __block MainListViewController *mainListVC;
        
        beforeEach(^{
            mainListVC = [[MainListViewController alloc] initWithNibName:@"MainListViewController_iPhone" bundle:nil];
            UIView *view = mainListVC.view;
            
            view = nil;
        });
        
        it(@"is not nil", ^{
            [[mainListVC shouldNot] beNil];
        });
        it(@"has a view", ^{
            [[theValue(mainListVC.view) shouldNot] beNil];
        });
        
        it(@"should have a collection view", ^{
            
            UICollectionView *collectionV = (UICollectionView *)[mainListVC imagesCollection];
            [[collectionV shouldNot] beNil];
            id dataSource = collectionV.dataSource;
            [[dataSource shouldNot] beNil];
            
            id delegate = collectionV.delegate;
            [[delegate shouldNot] beNil];
        });
        
        it(@"should load Collection IBOutlet", ^{
            
            [[theValue(mainListVC.imagesCollection) shouldNot] beNil];
        });
        
        it(@"should load SearchBar IBOutlet", ^{
            
            [[theValue(mainListVC.searchBar) shouldNot] beNil];
        });
        
        it(@"should be able to select a image to see details", ^{
           
            [mainListVC.imagesCollection selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                      animated:YES
                                                scrollPosition:UICollectionViewScrollPositionNone];
            
            UIViewController *topViewController = mainListVC.navigationController.topViewController;
            
            [[topViewController shouldEventually]beKindOfClass:[ImageDetailViewController class]];
        });
        
        afterAll(^{
            mainListVC = nil;
        });
    });
});


SPEC_END
