//
//  WAActivityView.m
//  WeatherApp
//
//  Created by Rohith R Gurram on 9/14/16.
//  Copyright © 2016 Rohith R Gurram. All rights reserved.
//

#import "WAActivityView.h"

@interface WAActivityView()

@property (nonatomic, strong) UIImageView *spinnerImage;

@end

@implementation WAActivityView

#pragma mark - UIView overrides

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    _spinnerImage = [[UIImageView alloc] initWithImage:[self imageMatchingScreenDensity]];
    [_spinnerImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_spinnerImage];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_spinnerImage
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_spinnerImage
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
    _animating = NO;
    
    [self setHidden:[self hidesWhenStopped]];
}

- (CGSize)intrinsicContentSize
{
    return [[[self spinnerImage] image] size];
}

#pragma mark - Image definitions (inline Base64-encoded)

- (UIImage *)imageMatchingScreenDensity
{
    switch ((NSInteger)[[UIScreen mainScreen] scale]) {
        case 1:
        default:
            return [self image1x];
            
        case 2:
            return [self image2x];
            
        case 3:
            return [self image3x];
    }
}

- (UIImage *)image1x
{
    NSString * const b64Data = @"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";
    return [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:b64Data options:0] scale:1.0];
}

- (UIImage *)image2x
{
    NSString * const b64Data = @"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";
    return [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:b64Data options:0] scale:2.0];
}

- (UIImage *)image3x
{
    NSString * const b64Data = @"iVBORw0KGgoAAAANSUhEUgAAAFQAAABUCAYAAAAcaxDBAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2hpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowQTgwMTE3NDA3MjA2ODExODA4M0EzRkNBQkYwNkRGMyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpFN0Y3RDkxMUE4QjAxMUU0Qjk3MEIxQzkzQ0Q1OUQyNCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpFN0Y3RDkxMEE4QjAxMUU0Qjk3MEIxQzkzQ0Q1OUQyNCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NDA2MzJFREMxMjIwNjgxMTgyMkFFQTA4MkNGQkM2QjIiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MEE4MDExNzQwNzIwNjgxMTgwODNBM0ZDQUJGMDZERjMiLz4gPC9yZGY6RGVzY3Jp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";
    return [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:b64Data options:0] scale:3.0];
}

#pragma mark - UIActivityIndicatorView methods

- (void)startAnimating
{
    if (!_animating)
    {
        [self setHidden:NO];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [animation setFromValue:@(0.0)];
        [animation setToValue:@(M_PI * 2.0)];
        [animation setDuration:0.6f];
        [animation setRepeatCount:INFINITY];
        [[[self spinnerImage] layer] addAnimation:animation forKey:@"rotationAnimation"];
        
        _animating = YES;
    }
}

- (void)stopAnimating
{
    if (_animating)
    {
        _animating = NO;
        [[[self spinnerImage] layer] removeAllAnimations];
        [self setHidden:[self hidesWhenStopped]];
    }
}

@end
