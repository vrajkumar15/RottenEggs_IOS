//
//  MoviesDescViewController.m
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import "MoviesDescViewController.h"
#import "MoviesViewController.h"

@interface MoviesDescViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

//- (id)initWithMovie:(NSDictionary *)movie;

@property (nonatomic, weak) NSDictionary *movie;

@end

@implementation MoviesDescViewController
@synthesize reMovie;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.reMovie.title;
    self.synopsisLabel.text = self.reMovie.desc;
    [self.synopsisLabel sizeToFit];
    
   // self.reMovie.imgHigh = [self.reMovie.imgHigh.stringByR]
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.reMovie.imgHigh]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.posterIV.image = [UIImage imageWithData:data];
        NSLog(@"%@", object);
     }];
    
    self.reMovie.imgHigh = [self.reMovie.imgHigh stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    
 //   NSString *imgHighURL = imgHigh.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil);
    
     request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.reMovie.imgHigh]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        
        if(data != nil)
           self.posterIV.image = [UIImage imageWithData:data];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
