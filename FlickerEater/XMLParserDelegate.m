//
//  FlickerParser.m
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import "XMLParserDelegate.h"
#import "Photo.h"

NSString *const kEntryTagName = @"entry";
NSString *const kLinkTagName = @"link";
NSString *const kAuthorsNameTagName = @"name";
NSString *const kTitleTagName = @"title";
NSString *const kLinkTagAttributedDicRelationShipAttribute = @"rel";
NSString *const kRelationshipAttributeEnclosure = @"enclosure";
NSString *const kHiperlinkAttribute = @"href";

@interface XMLParserDelegate()

@property (nonatomic, retain)NSMutableArray *images;
@property (nonatomic, retain)Photo *photo;
@property (nonatomic, assign)BOOL hasEntryTagStarted;
@property (nonatomic, assign)BOOL hasAuthorsNameTagName;
@property (nonatomic, assign)BOOL hasTitleTagName;

@end

@implementation XMLParserDelegate

@synthesize hasEntryTagStarted = _hasEntryTagStarted;
@synthesize hasAuthorsNameTagName = _hasAuthorsNameTagName;
@synthesize hasTitleTagName = _hasTitleTagName;

@synthesize photo = _photo;
@synthesize images = _images;
@synthesize delegate = _delegate;


- (id)initWithDelegate:(id<FlickerParserDelegate>)delegate
{
    ASSERT(delegate);
    
    if ( (self = [self init])) {
        
        _delegate = delegate;
    }
    
    return self;
}

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
    if ([elementName isEqualToString:kLinkTagName] &&
        [[attributeDict objectForKey:kLinkTagAttributedDicRelationShipAttribute] isEqualToString:kRelationshipAttributeEnclosure]) {
        
        NSString *simpleString = [attributeDict objectForKey:kHiperlinkAttribute];
        
        if ([simpleString hasSuffix:@".jpg"] && [simpleString hasPrefix:@"http"]) {
            
            [_photo setUrl:simpleString];
        }
    }
    if ([elementName isEqualToString:kAuthorsNameTagName]) {
        _hasAuthorsNameTagName = YES;
    }
    
    if ([elementName isEqualToString:kTitleTagName]) {
        _hasTitleTagName = YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
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
        
        self.photo = nil;
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
