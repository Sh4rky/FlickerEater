//
//  FlickerParser.m
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "FlickerParser.h"


NSString *const kEntryTagName = @"entry";
NSString *const kContentTagName = @"content";

@interface FlickerParser()

@property (nonatomic, retain)NSMutableArray *imagesURLs;
@property (nonatomic, assign)BOOL hasEntryTagStarted;
@property (nonatomic, assign)BOOL hasContentTagStarted;

@end

@implementation FlickerParser

@synthesize hasEntryTagStarted = _hasEntryTagStarted;
@synthesize hasContentTagStarted = _hasContentTagStarted;

@synthesize imagesURLs = _imagesURLs;
@synthesize delegate = _delegate;

- (void)dealloc {
    [super dealloc];
    
    [_imagesURLs release];
    _delegate = nil;
}

-(id)init {
    [super init];
    
    self.imagesURLs = [NSMutableArray array];
    
    return self;
}

#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:kEntryTagName]){
        _hasEntryTagStarted = YES;
    }
    if ([elementName isEqualToString:kContentTagName]) {
        _hasContentTagStarted = YES;
    }
    
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_hasContentTagStarted)
    {
        NSArray *stringsArray = [string componentsSeparatedByString:@";"];
        
        for (NSString *simpleString in stringsArray) {
            ASSERT_CLASS(simpleString, NSString);
            
            if ([simpleString hasSuffix:@".jpg"] && [simpleString hasPrefix:@"http"]) {
                
                [_imagesURLs addObject:simpleString];
            }
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:[NSString stringWithFormat:@"/%@", kEntryTagName]]){
        _hasEntryTagStarted = NO;
    }
    if ([elementName isEqualToString:[NSString stringWithFormat:@"/%@", kContentTagName]]) {
        _hasContentTagStarted = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    ASSERT(_delegate);
    
    [_delegate flickerParserEnded:_imagesURLs];
}

@end
