//
//  FlickerParser.m
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "FlickerParser.h"
#import "Photo.h"

NSString *const kEntryTagName = @"entry";
NSString *const kContentTagName = @"content";
NSString *const kAuthorsNameTagName = @"name";
NSString *const kTitleTagName = @"title";

@interface FlickerParser()

@property (nonatomic, retain)NSMutableArray *images;
@property (nonatomic, retain)Photo *photo;
@property (nonatomic, assign)BOOL hasEntryTagStarted;
@property (nonatomic, assign)BOOL hasContentTagStarted;
@property (nonatomic, assign)BOOL hasAuthorsNameTagName;
@property (nonatomic, assign)BOOL hasTitleTagName;

@end

@implementation FlickerParser

@synthesize hasEntryTagStarted = _hasEntryTagStarted;
@synthesize hasContentTagStarted = _hasContentTagStarted;
@synthesize hasAuthorsNameTagName = _hasAuthorsNameTagName;
@synthesize hasTitleTagName = _hasTitleTagName;

@synthesize photo = _photo;
@synthesize images = _images;
@synthesize delegate = _delegate;


-(id)init {
    
    if((self = [super init])){
    
        self.images = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:kEntryTagName]){
        
        Photo *photo = [[Photo alloc] init];
        
        self.photo = photo;
        
        _hasEntryTagStarted = YES;
    }
    if ([elementName isEqualToString:kContentTagName]) {
        
        _hasContentTagStarted = YES;
    }
    if ([elementName isEqualToString:kAuthorsNameTagName]) {
        _hasAuthorsNameTagName = YES;
    }
    
    if ([elementName isEqualToString:kTitleTagName]) {
        _hasTitleTagName = YES;
    }
    
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_hasContentTagStarted)
    {
        NSArray *stringsArray = [string componentsSeparatedByString:@";"];
        
        for (NSString *simpleString in stringsArray) {
            ASSERT_CLASS(simpleString, NSString);
            
            if ([simpleString hasSuffix:@".jpg"] && [simpleString hasPrefix:@"http"]) {
                
                [_photo setUrl:simpleString];
            }
        }
    }
    
    if (_hasAuthorsNameTagName) {
        [_photo setUsername:string];
    }
    
    if (_hasTitleTagName) {
        [_photo setTitle:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:kEntryTagName]){
        _hasEntryTagStarted = NO;
        
        [_images addObject:_photo];
        
    }
    if ([elementName isEqualToString:kContentTagName]) {
        _hasContentTagStarted = NO;
    }
    
    if ([elementName isEqualToString:kAuthorsNameTagName]) {
        _hasAuthorsNameTagName = NO;
    }
    
    if ([elementName isEqualToString:kTitleTagName]) {
        _hasTitleTagName = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    ASSERT(_delegate);
    
    [_delegate flickerParserEnded:_images];
    
    self.images = nil;
}

@end
