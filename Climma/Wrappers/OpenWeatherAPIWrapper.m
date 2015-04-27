//
//  OpenWeatherAPIWrapper.m
//  Climma
//
//  Created by Máximo De León on 4/19/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import "OpenWeatherAPIWrapper.h"

#define API_MAIN_URL @"http://api.openweathermap.org/data/"
#define API_VERSION @"2.5/"
#define API_WEATHER_URL @"weather"
#define API_QUERY_URL_PLACEHOLDER @"?q="

#define WEATHER_KEY @"weather"
#define WEATHER_DESCRIPTION_KEY @"description"
#define WEATHER_CITY_NAME_KEY @"name"
#define WEATHER_MAIN_TEMP_KEY @"main"
#define WEATHER_TEMP_KEY @"temp"
#define WEATHER_TEMP_MIN_KEY @"temp_min"
#define WEATHER_TEMP_MAX_KEY @"temp_max"
#define WEATHER_ICON_KEY @"icon"
#define NOT_FOUND_COD_KEY @"cod"
#define NOT_FOUND_COD @"404"
#define NOT_FOUND_MESSAGE_KEY @"message"

#import "OpenWeatherAPIWrapper.h"


@implementation OpenWeatherAPIWrapper

- (NSDictionary *) callAPIForCity: (NSString *) cityName {
	//Declare local variables to use for the request
	NSString *fullURL = [NSString stringWithFormat:@"%@%@%@%@%@%@", API_MAIN_URL, API_VERSION, API_WEATHER_URL, API_QUERY_URL_PLACEHOLDER, cityName,@"&units=metric"];
	NSMutableDictionary *returnData = [[NSMutableDictionary alloc] init];
	NSURLResponse *resp;
	NSDictionary *callResponseData;
	NSURL *url;
	NSError *apiErrorObject;
	
	//Call api
	url = [NSURL URLWithString:fullURL];
	_apiRequestObject = [NSURLRequest requestWithURL:url];
	_apiResponseDataObject = [NSURLConnection sendSynchronousRequest:_apiRequestObject returningResponse:&resp error:&apiErrorObject];
	
	callResponseData = [NSJSONSerialization JSONObjectWithData:_apiResponseDataObject options:0 error:nil];
	
	// fill data to be returned
	[returnData setObject:[self findCityNameInJSON:callResponseData] forKey:@"name"];
	[returnData setObject:[self findWeatherKeyValueInJSON:callResponseData] forKey:@"weather"];
	[returnData setValue:[self findTempKeyValueInJSON:callResponseData] forKey: @"temp"];
	[returnData setValue:[self findMinTempKeyValueInJSON:callResponseData] forKey: @"min_temp"];
	[returnData setValue:[self findMaxTempKeyValueInJSON:callResponseData] forKey: @"max_temp"];
	[returnData setValue:[self findIconInJSON:callResponseData] forKey:@"icon"];
	
	return returnData;
}

- (NSString *) findWeatherKeyValueInJSON : (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_KEY] != nil) {
		NSArray *weahterConditions = [returnedData valueForKey:WEATHER_KEY];
		NSDictionary *weatherConditionsData = [weahterConditions objectAtIndex:0];
		return [weatherConditionsData valueForKey:WEATHER_DESCRIPTION_KEY];
	}
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

- (NSString *) findTempKeyValueInJSON : (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY] != nil) {
		NSDictionary *tempValues = [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY];
		NSString *temperature = [NSString stringWithFormat:@"%@", [tempValues valueForKey:WEATHER_TEMP_KEY]];
		return temperature;
   }
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

- (NSString *) findMinTempKeyValueInJSON: (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY] != nil) {
		NSDictionary *tempValues = [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY];
		NSString *temperature = [NSString stringWithFormat:@"%@", [tempValues valueForKey:WEATHER_TEMP_MIN_KEY]];
		return temperature;
	}
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

- (NSString *) findMaxTempKeyValueInJSON: (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY] != nil){
		NSDictionary *tempValues = [returnedData valueForKey:WEATHER_MAIN_TEMP_KEY];
		NSString *temperature = [NSString stringWithFormat:@"%@", [tempValues valueForKey:WEATHER_TEMP_MAX_KEY]];
		return temperature;
	}
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

- (NSString *) findCityNameInJSON : (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_CITY_NAME_KEY] != nil){
		return [returnedData valueForKey:WEATHER_CITY_NAME_KEY];
	}
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

- (NSString *) findIconInJSON : (NSDictionary *) returnedData {
	if (returnedData != nil && [returnedData valueForKey:WEATHER_KEY] != nil) {
		NSArray *weahterConditions = [returnedData valueForKey:WEATHER_KEY];
		NSDictionary *weatherConditionsData = [weahterConditions objectAtIndex:0];
		NSString *icon = [weatherConditionsData valueForKey:WEATHER_ICON_KEY];
		return icon;
	}
	else if ([returnedData valueForKey:NOT_FOUND_COD_KEY] != nil && [[returnedData valueForKey:NOT_FOUND_COD_KEY]  isEqual: NOT_FOUND_COD] ) {
		return[returnedData valueForKey:NOT_FOUND_MESSAGE_KEY];
	}
	
	return @" ";
}

@end