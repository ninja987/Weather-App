//
//  WAWeatherResponse.m
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import "WAWeatherResponse.h"

@implementation WAWeatherResponse

- (instancetype)initWithResponse:(NSDictionary *)returnedDictionary
{
    self = [super init];
    if (self) {
        if (returnedDictionary[@"coord"] != [NSNull null])
        {
            double lat = [returnedDictionary[@"coord"][@"lat"] doubleValue];
            double lon = [returnedDictionary[@"coord"][@"lon"] doubleValue];
            NSString *latitude = [NSString stringWithFormat:@"%.2f", lat];
            NSString *longitude = [NSString stringWithFormat:@"%.2f", lon];
            NSString *coordinates = [NSString stringWithFormat:@"%@, %@", latitude, longitude];
            [self setCoordinates:coordinates];
        }
        if (returnedDictionary[@"base"] != [NSNull null])
        {
            [self setBase:returnedDictionary[@"base"]];
        }
        if (returnedDictionary[@"main"] != [NSNull null])
        {
            NSString *pressure = returnedDictionary[@"main"][@"pressure"];
            NSString *humidity = returnedDictionary[@"main"][@"humidity"];
            double temp = [returnedDictionary[@"main"][@"temp"] doubleValue] - 273.15;
            NSString *temperature = [NSString stringWithFormat:@"%ld C", (long)temp];

            [self setHumidity:[NSString stringWithFormat:@"%@ percent", humidity]];
            [self setPressure:[NSString stringWithFormat:@"%@ hpa", pressure]];
            [self setTemperature:temperature];
        }
        if (returnedDictionary[@"wind"] != [NSNull null])
        {
            NSString *speed = returnedDictionary[@"wind"][@"speed"];
            [self setWindSpeed:[NSString stringWithFormat:@"%@ m/s", speed]];
        }
        if (returnedDictionary[@"clouds"] != [NSNull null])
        {
            [self setCloudDict:returnedDictionary[@"clouds"]];
        }
        if ((returnedDictionary[@"sys"] != [NSNull null]) && (returnedDictionary[@"name"] != [NSNull null]))
        {
            NSString *city = returnedDictionary[@"name"];
            NSString *country = returnedDictionary[@"sys"][@"country"];
            NSString *address = [NSString stringWithFormat:@"%@, %@", city, country];

            NSString *sunriseTime = [self convertToDateFromUnixTime:[returnedDictionary[@"sys"][@"sunrise"] doubleValue]];
            NSString *sunsetTime = [self convertToDateFromUnixTime:[returnedDictionary[@"sys"][@"sunset"] doubleValue]];
                        
            [self setSunrise:sunriseTime];
            [self setSunset:sunsetTime];
            [self setCity:address];
        }
        if (returnedDictionary[@"dt"] != [NSNull null])
        {
            [self setCDate:returnedDictionary[@"dt"]];
        }
        if (returnedDictionary[@"cod"] != [NSNull null])
        {
            [self setCod:returnedDictionary[@"cod"]];
        }
        if (returnedDictionary[@"weather"] != [NSNull null])
        {
            WAWeatherDataModel *weatherDataModel = [[WAWeatherDataModel alloc] initWithData:returnedDictionary[@"weather"][0]];
            [self setWeatherModel:weatherDataModel];
        }
    }
    return self;
}

/*!
 * @discussion Converts unix time stamp to regular NSDate Formatted time.
 * @param unixTime which needs to be converted.
 * @return NSString.
 */
- (NSString *)convertToDateFromUnixTime:(double)unixTime
{
    NSTimeInterval _interval = unixTime;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"HH:MM"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
