//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Rajkumar Vijayan on 9/14/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MoviesDescViewController.h"
#import "REMovie.h"

int lastClickedRow;

@interface MoviesViewController (){
UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *viewActivity;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLbl;


@property (nonatomic, strong) NSArray *movies;
- (IBAction)onListSelect:(id)sender;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"Rotten Eggs";
        [self.viewActivity startAnimating];
        [self.viewActivity sizeToFit];

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 125;
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MovieCellTableViewCell" bundle:nil]forCellReuseIdentifier:@"MovieCell"];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (connectionError) {
            [self showNetworkError];
        }
        else {
            [self hideNetworkError];


        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.movies = object[@"movies"];
        [self.tableview reloadData];
        }
    
      //  self.lblNetwork.hidden = (connectionError == nil);
     
        [self.viewActivity stopAnimating];
        
        NSLog(@"movies: %@", self.movies);
    }];
    
  //  refreshControl = [[UIRefreshControl alloc]init];
  //  [self.tableview addSubview:refreshControl];
  //  [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UITableViewController *tvc = [[UITableViewController alloc] init];
    tvc.tableView = self.tableview;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    tvc.refreshControl = refreshControl;
    
}

- (void)refresh:(id)sender
{
    [self hideNetworkError];
    [self refreshTable];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void) hideNetworkError
{
    self.networkErrorLbl.alpha = 0;
}


- (void)refreshTable {
    //TODO: refresh your data
    
    [self.viewActivity startAnimating];
    
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (connectionError) {
            [self showNetworkError];
        }
        else {
            [self hideNetworkError];
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.movies = object[@"movies"];
        [self.tableview reloadData];
        }
    
       // self.lblNetwork.hidden = (connectionError == nil);
     //   NSLog(@"movies: %@", self.movies);
    }];
    
     //   self.lblNetwork.hidden = (connectionError == nil);
    
     [self.refreshControl endRefreshing];
        
        [self.viewActivity stopAnimating];
    [self.viewActivity removeFromSuperview];
    
}

- (void) showNetworkError
{
    [UIView animateWithDuration: 0.5
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         self.networkErrorLbl.alpha = 1.0;
                         self.networkErrorLbl.text = @"Network Error!";
                     }
                     completion: ^(BOOL finished){
                         NSLog(@"Done!");
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath {
//    int lastClickedRow = indexPath.row;
    NSLog(@"index path: %ld", (long)indexPath.row);
    NSDictionary *movie = self.movies[indexPath.row];
    
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    REMovie *reMovie = [[REMovie alloc] initWithDictionary:self.movies[indexPath.row]];
    cell.titleLabel.text = reMovie.title;
    cell.synopsisLabel.text = reMovie.desc;
    
  //  cell.titleLabel.text = movie[@"title"];
   // cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
   // NSString *posterUrl = [reMovie valueForKeyPath:@"posters.thumbnail"];

    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    // cell.posterView.image = [UIImage imageWithData:data];
    ////  UITableViewCell *cell = [[UITableViewCell alloc] init];
    
                    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // REMovie *reMovie = self.movies[indexPath.row];
   // NSLog(@"index clicked: %@", reMovie);
     REMovie *reMovie = [[REMovie alloc] initWithDictionary:self.movies[indexPath.row]];
    
    MoviesDescViewController *smv = [[MoviesDescViewController alloc] init];
    smv.reMovie = reMovie;
    
    [self.navigationController pushViewController:smv animated:YES];

    
 //  [self.navigationController pushViewController:[[MoviesDescViewController alloc] initWithMovie:movie] animated:YES];
}





@end
