//
//  SearchViewController.h
//  Climma
//
//  Created by Máximo De León on 4/20/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;
@property NSMutableArray *cities;
@property NSString *selectedCity;

- (NSString *) urlEncode : (NSString *) text;
- (NSString *) formatCityName : (NSString *) cityNameFromSearchResult;

@end
