//
//  WANetworkClass.h
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WANetworkClass : NSObject

/*!
 * @discussion Downloads the Data and convert it into Json format .
 * @param urlStr takes the url to download from.
 * @return void.
 */

- (void)downloadJsonDataWithUrl:(nonnull NSString *)urlStr
              completionHandler:(nullable void (^)(NSDictionary * _Nullable results, NSError * _Nonnull error))completionHandler;

@end
