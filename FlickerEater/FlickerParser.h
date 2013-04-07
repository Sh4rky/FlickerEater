//
//  FlickerParser.h
//  FlickerEater
//
//  Created by Mac Franco on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlickerParserDelegate

- (void)flickerParserEnded:(NSMutableArray *)imagesUrls;

@end

@interface FlickerParser : NSObject <NSXMLParserDelegate>

@property(nonatomic, assign)id<FlickerParserDelegate>delegate;

@end
