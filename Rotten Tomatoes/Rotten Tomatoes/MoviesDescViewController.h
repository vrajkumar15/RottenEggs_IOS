//
//  MoviesDescViewController.h
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMovie.h"

@interface MoviesDescViewController : UIViewController{

REMovie *reMovie;
}

@property (nonatomic, retain) REMovie *reMovie;

@end
