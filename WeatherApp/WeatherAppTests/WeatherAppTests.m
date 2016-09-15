//
//  WeatherAppTests.m
//  WeatherAppTests
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WANetworkClass.h"
#import "WAWeatherDataModel.h"

NSString * const kWAUrlString = @"http://api.openweathermap.org/data/2.5/weather?q=Westervile,oh,us&APPID=789d25f2b8cfa2c3f5a045e1dec5a2a1";

float kWAExpectationTimeout = 1.0f;

@interface WeatherAppTests : XCTestCase

@property WANetworkClass *networkClass;
@property WAWeatherDataModel *dataModel;

@end

@implementation WeatherAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloadJsonData
{
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Download JSON Data for a given URL"];
    
    self.networkClass = [[WANetworkClass alloc] init];
    [self.networkClass downloadJsonDataWithUrl:kWAUrlString completionHandler:^(NSDictionary * _Nullable results, NSError * _Nonnull error) {
        if (error == nil) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:kWAExpectationTimeout handler:^(NSError * _Nullable error)
     {
         if (error != nil) {
             XCTFail(@"Failed to download JSON data");
         }
         else
         {
             XCTAssert(YES, @"Download successfull");
         }
         
     }];
}

- (void)testDownloadImageforIcon
{
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Download Image for a given icon"];
    self.dataModel = [[WAWeatherDataModel alloc] init];
    UIImage *downloadedImage = [self.dataModel downloadImageForIcon:@"01d"];
    
    if (downloadedImage != nil) {
        [expectation fulfill];
    }
    [self waitForExpectationsWithTimeout:kWAExpectationTimeout handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Failed to download Image");
        }
        else
        {
            XCTAssert(YES, @"Image downloaded successfully");
        }
    }];
}


@end
