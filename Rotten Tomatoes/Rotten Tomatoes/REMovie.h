//
//  REMovie.h
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REMovie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgLow;
@property (nonatomic, strong) NSString *imgHigh;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
