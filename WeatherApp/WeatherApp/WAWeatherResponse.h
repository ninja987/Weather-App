//
//  WAWeatherResponse.h
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAWeatherDataModel.h"

@interface WAWeatherResponse : NSObject

//Main Dict objects
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *temperature;

//Sys Dict objects
@property (nonatomic, strong) NSString *sunrise;
@property (nonatomic, strong) NSString *sunset;
@property (nonatomic, strong) NSString *city;

@property(nonatomic, strong) NSString *coordinates;
@property(nonatomic, strong) NSString *base;
@property(nonatomic, strong) NSString *windSpeed;
@property(nonatomic, strong) NSDictionary *cloudDict;
@property(nonatomic, strong) NSNumber *cDate;
@property(nonatomic, strong) NSNumber *cod;
@property(nonatomic, strong) NSString *wId;

/*!
 * @brief The weatherModel is an object of WAWeatherDataModel class .
 */
@property(nonatomic, strong) WAWeatherDataModel *weatherModel;

/*!
 * @discussion Initialises the data model with the dictionary returned from service call.
 * @param returnedDictionary which is the dictionary obtained from the response of the service call.
 * @return instancetype.
 */
- (instancetype)initWithResponse:(NSDictionary *)returnedDictionary;

@end
