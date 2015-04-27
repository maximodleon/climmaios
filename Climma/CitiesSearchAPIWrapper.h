//
//  CitiesSearchAPIWrapper.h
//  Climma
//
//  Created by Máximo De León on 4/21/15.
//  Copyright (c) 2015 Máximo De León. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesSearchAPIWrapper : NSObject
- (NSMutableArray *) searchForInputText : (NSString *) inputText;
- (NSString *) urlEncode : (NSString *) text;
@end
