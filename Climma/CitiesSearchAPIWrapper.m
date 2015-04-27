//
//  CitiesSearchAPIWrapper.m
//  Climma
//
//  Created by Máximo De León on 4/21/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import "CitiesSearchAPIWrapper.h"

#define API_URL @"http://gd.geobytes.com/AutoCompleteCity?callback=&q="

@implementation CitiesSearchAPIWrapper

- (NSMutableArray *) searchForInputText : (NSString *) inputText {
	
	
	NSURLResponse *response;
	NSError *error;
	NSString *textFormatted = [self urlEncode:inputText];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_URL, textFormatted]];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	NSMutableArray *returnCitiesList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
	
	
	return returnCitiesList;
	
}

- (NSString *) urlEncode : (NSString *) text {
	NSString *returnString;
	
	if (text != nil) {
		returnString = [text stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
	}
	
	return returnString;
}

@end
