//
//  FlickerParserTest.m
//  FlickerEater
//
//  Created by Gonzalo G Erro on 5/22/15.
//  Copyright (c) 2015 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kiwi.h"
#import "MainListViewController.h"

SPEC_BEGIN(XMLParserDelegateTest)

describe(@"Parsing XML", ^{
    context(@"when created", ^{
        
        __block XMLParserDelegate *parserDelegate;
        __block MainListViewController *mainListVC;
        
        beforeEach(^{
            
            mainListVC = [[MainListViewController alloc] initWithNibName:@"MainListViewController_iPhone" bundle:nil];
            UIView *view = mainListVC.view;
            
            view = nil;
            
            parserDelegate = [[XMLParserDelegate alloc] initWithDelegate:mainListVC];
        });
        
        it(@"is not nil", ^{
            [[parserDelegate shouldNot] beNil];
        });
        it(@"should conform FlickerParserDelegate ", ^{
            
            [[mainListVC should] conformToProtocol:@protocol(FlickerParserDelegate)];
        });
        it(@"should call delegate method with parsed object", ^{
            
            [[[mainListVC shouldEventually] receive] flickerParserEnded:any()];
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            
            NSString *pathForMockXML = [bundle pathForResource:@"photos_public" ofType:@"xml"];
            
            NSData *mockedXMLData = [NSData dataWithContentsOfFile:pathForMockXML];
            
            NSXMLParser *parser = [[NSXMLParser alloc]initWithData:mockedXMLData];
            
            [parser setDelegate:parserDelegate];
            
            [parser parse];
            
        });
        it(@"delegate is not nil", ^{
            [[theValue(parserDelegate.delegate) shouldNot] beNil];
        });
        
        afterAll(^{
            mainListVC = nil;
            parserDelegate = nil;
        });
    });
});


SPEC_END

