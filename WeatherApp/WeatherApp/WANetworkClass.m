//
//  WANetworkClass.m
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import "WANetworkClass.h"

@implementation WANetworkClass

- (void)downloadJsonDataWithUrl:(nonnull NSString *)urlStr
              completionHandler:(nullable void (^)(NSDictionary * _Nullable results, NSError * _Nullable error))completionHandler
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                      NSMutableDictionary *returnedDict = nil;
                                      if (error != nil)
                                      {
                                          NSString *message = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
                                          NSDictionary *userInfo = @{
                                                                     NSLocalizedDescriptionKey : message
                                                                     };
                                          error = [NSError errorWithDomain:@"Error"
                                                                      code:statusCode
                                                                  userInfo:userInfo];
                                          completionHandler (nil, error);
                                      }
                                      else
                                      {
                                          returnedDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                          if (completionHandler) {
                                              completionHandler(returnedDict, nil);
                                          }
                                      }
                                      NSLog(@"%@",returnedDict);
                                      
                                  }];
    [task resume];
}

@end
