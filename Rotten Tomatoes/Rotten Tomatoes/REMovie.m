//
//  REMovie.m
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import "REMovie.h"

@implementation REMovie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.desc = dictionary[@"synopsis"];
        self.imgLow = dictionary[@"posters"][@"thumbnail"];
        self.imgHigh = dictionary[@"posters"][@"original"];
    }
    
    return self;
}

@end