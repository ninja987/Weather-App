//
//  WAActivityView.h
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAActivityView : UIView

@property (nonatomic, readonly, getter = isAnimating) BOOL animating;
@property (nonatomic, assign) IBInspectable BOOL hidesWhenStopped;

/*!
 * @discussion Makes the ActivityView to start animating.
 * @param no parameters needed.
 * @return void.
 */
- (void)startAnimating;

/*!
 * @discussion Makes the ActivityView to stop animating.
 * @param no parameters needed.
 * @return void.
 */
- (void)stopAnimating;

@end
