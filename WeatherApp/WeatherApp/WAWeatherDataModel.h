//
//  WAWeatherDataModel.h
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WAWeatherDataModel : NSObject

@property(nonatomic, strong) NSString *wId;
@property(nonatomic, strong) NSString *wMain;
@property(nonatomic, strong) NSString *wDescription;
@property(nonatomic, strong) UIImage *wIconImage;

/*!
 * @discussion Initialises the data model with the dictionary.
 * @param data is a dictionary which gets parsed and helps in downloading image.
 * @return instancetype.
 */
- (instancetype)initWithData:(NSDictionary *)data;

/*!
 * @discussion Downloads the image for the icon received.
 * @param icon which is returned as a part of service response.
 * @return UIImage.
 */
- (UIImage *)downloadImageForIcon:(NSString *)icon;

@end
