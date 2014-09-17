//
//  MovieCellTableViewCell.h
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
