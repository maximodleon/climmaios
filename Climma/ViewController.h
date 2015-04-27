//
//  ViewController.h
//  Climma
//
//  Created by Máximo De León on 1/3/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *CityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperature;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperature;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property NSString *cityName;
@property (weak, nonatomic) IBOutlet UILabel *notFoundLabel;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (void) searchForCurrentCityName;

@end

