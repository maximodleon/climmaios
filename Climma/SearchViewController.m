//
//  SearchViewController.m
//  Climma
//
//  Created by Máximo De León on 4/20/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import "SearchViewController.h"
#import "CitiesSearchAPIWrapper.h"


@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[_searchBox setDelegate:self];
	[_searchResultsTable setDataSource:self];
	[_searchResultsTable setDelegate:self];
	[_searchBox setShowsCancelButton:YES];
	[_searchBox setShowsBookmarkButton:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchBar : (UISearchBar *) searchBar textDidChange:(NSString *)searchText {
	
	if ([searchText length] >= 3) {
		CitiesSearchAPIWrapper *wrapper = [[CitiesSearchAPIWrapper alloc] init];
		_cities = [wrapper searchForInputText:searchText];
		[_searchResultsTable reloadData];
	}
	else if ([searchText length] == 0) {
		_cities = [[NSMutableArray alloc] init];
		[_searchResultsTable reloadData];
	}
	
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {

}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_cities count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell" forIndexPath:indexPath];
	
	// Configure the cell...
	cell.textLabel.text = [_cities objectAtIndex:indexPath.row];
	
	return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [_searchResultsTable cellForRowAtIndexPath:indexPath];
	
	
	_selectedCity = [self formatCityName : cell.textLabel.text];
	_selectedCity = [self urlEncode:_selectedCity];
	//NSLog(@"%@",cell.textLabel.text);
	//[self.navigationController popToRootViewControllerAnimated:YES];
	[self performSegueWithIdentifier:@"SearchFinishedSegue" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *) urlEncode : (NSString *) text {
	NSString *returnString;
	
	if (text != nil) {
		returnString = [text stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
	}
	
	return returnString;
}

- (NSString *) formatCityName : (NSString *) cityNameFromSearchResult {
	NSArray *cityNameSplit =  [cityNameFromSearchResult componentsSeparatedByString:@","];
	NSError *err = nil;
	NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
	NSArray *transaction = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
	NSString *countryName = [cityNameSplit objectAtIndex:2];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(Name contains[cd] %@)",  [countryName substringFromIndex:1]];
	NSArray *results = [transaction filteredArrayUsingPredicate:predicate];
	NSData *countryISOInfo = [results objectAtIndex:0];
	
	NSString *returnString = [NSString stringWithFormat:@"%@,%@",[cityNameSplit objectAtIndex:0], [countryISOInfo valueForKey:@"Code"]];
	
	return returnString;
}

@end
