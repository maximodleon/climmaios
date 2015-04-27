//
//  OpenWeatherAPIWrapper.h
//  Climma
//
//  Created by Máximo De León on 4/19/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenWeatherAPIWrapper : NSObject

   @property NSURLRequest *apiRequestObject;
   @property NSData *apiResponseDataObject;

   - (NSDictionary *) callAPIForCity: (NSString *) cityName;
   - (NSString *) findWeatherKeyValueInJSON: (NSDictionary *)returnedData;
   - (NSString *) findTempKeyValueInJSON : (NSDictionary *) returnedData;
   - (NSString *) findMinTempKeyValueInJSON: (NSDictionary *) returnedData;
   - (NSString *) findMaxTempKeyValueInJSON: (NSDictionary *) returnedData;
   - (NSString *) findCityNameInJSON : (NSDictionary *) returnedData;
   - (NSString *) findIconInJSON : (NSDictionary *) returnedData;

@end


