//
//  WAWeatherDataModel.m
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import "WAWeatherDataModel.h"

@implementation WAWeatherDataModel

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data[@"description" ] != [NSNull null]) {
            [self setWDescription:data[@"description"]];
        }
        if (data[@"main"] != [NSNull null]) {
            [self setWMain:data[@"main"]];
        }
        if (data[@"id"] != [NSNull null]) {
            [self setWId:data[@"id"]];
        }
        if (data[@"icon"] != [NSNull null]) {
            [self setWIconImage:[self downloadImageForIcon:data[@"icon"]]];
        }
    }
    return self;
}

- (UIImage *)downloadImageForIcon:(NSString *)icon
{
    NSString *urlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", icon];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

@end
