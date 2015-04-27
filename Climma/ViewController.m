//
//  ViewController.m
//  Climma
//
//  Created by Máximo De León on 1/3/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import "ViewController.h"
#import "OpenWeatherAPIWrapper.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if (_cityName == nil){
		_cityName = @"london";
	}
	[_notFoundLabel setHidden:YES];
	[self searchForCurrentCityName];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
  SearchViewController *source = [segue sourceViewController];
	_cityName = source.selectedCity;
	[self searchForCurrentCityName];
}


- (void) searchForCurrentCityName {
	OpenWeatherAPIWrapper *wrapper = [[OpenWeatherAPIWrapper alloc] init];
	NSDictionary *weatherInfo = [wrapper callAPIForCity:_cityName];
	
	if  ([[weatherInfo valueForKey:@"name"] isEqual:@"Error: Not found city"]) {
		[_notFoundLabel setText:@"No se encontró la ciudad"];
		[_notFoundLabel setHidden:NO];
		_CityLabel.text = @"";
		_weatherLabel.text = @"";
		_temperatureLabel.text = @"";
		_minTemperature.text = @"";
		_maxTemperature.text = @"";
		[_weatherIcon setImage:[UIImage imageNamed:[weatherInfo valueForKey:@" "]]];
	}
    else {
		[_notFoundLabel setHidden:YES];
		_CityLabel.text = [weatherInfo valueForKey:@"name"];
		_weatherLabel.text = [weatherInfo valueForKey:@"weather"];
		_temperatureLabel.text = [weatherInfo valueForKey:@"temp"];
		_minTemperature.text = [weatherInfo valueForKey:@"min_temp"];
		_maxTemperature.text = [weatherInfo valueForKey:@"max_temp"];
		[_weatherIcon setImage:[UIImage imageNamed:[weatherInfo valueForKey:@"icon"]]];
   }
}
@end
