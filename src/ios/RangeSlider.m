//
//  RangeSlider.m
//  Will put a native range slider
//
//  Created by Yariv Katz on 19/11/14.
//  Copyright (c) 2012-2014 Nerdz LTD All rights reserved.
//  Website: http://www.nerdeez.com
//

#import "RangeSlider.h"
#import "NMRangeSlider.h"


@implementation RangeSlider

/**
 * We need to access the web view so we can reach the super view to add our native component
 */
- (CDVPlugin*) initWithWebView:(UIWebView *)theWebView
{
    self = (RangeSlider*)[super initWithWebView:theWebView];
    return self;
}

/**
 * display a range slider on the screen
 */
- (void)showSlider:(CDVInvokedUrlCommand *)command{
    
    //grab the params from the js
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    int maximumValue = [options integerValueForKey:@"maximumValue" defaultValue:60];
    int minimumValue = [options integerValueForKey:@"minimumValue" defaultValue:14];
    int stepValue = [options integerValueForKey:@"stepValue" defaultValue:4];
    
    //create the slider
    CGRect sliderFrame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height/2, [[UIScreen mainScreen] bounds].size.width, 100);
    self.rangeSlider = [[NMRangeSlider alloc] initWithFrame:sliderFrame];
    [self.rangeSlider setMaximumValue:(float)maximumValue];
    [self.rangeSlider setMinimumValue:(float)minimumValue];
    [self.rangeSlider setStepValue:(float)stepValue];
    [self.rangeSlider setMinimumRange:(float)4];
    [self.rangeSlider setUpperValue:(float)maximumValue];
    [self.rangeSlider setLowerValue:(float)minimumValue];
    
    //attach observers for the values of the slider
    [self.rangeSlider addObserver:self forKeyPath:@"upperValue" options:NSKeyValueObservingOptionOld context:nil];
    [self.rangeSlider addObserver:self forKeyPath:@"lowerValue" options:NSKeyValueObservingOptionOld context:nil];
    
    //attach the slider to the view
    [self.webView.superview addSubview:self.rangeSlider];
    [self.webView.superview bringSubviewToFront:self.rangeSlider];
    
}

/**
 * hides the range slider from view
 */
- (void)hideSlider:(CDVInvokedUrlCommand *)command{
    [self.rangeSlider removeFromSuperview];
}

/**
 * get the lower handle of the range slider
 */
- (void)getMin:(CDVInvokedUrlCommand *)command{
    int minValue = (int)[self.rangeSlider lowerValue];
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:minValue];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

/**
 * observer for when the value of the range slider is changing
 * when value is change then run an event for that
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self writeJavascript:@"setTimeout( function() { cordova.fireDocumentEvent('rangeChanged') }, 0);"];
}

/**
 * get the upper value of the range slider
 */
- (void)getMax:(CDVInvokedUrlCommand *)command{
    int maxValue = (int)[self.rangeSlider upperValue];
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:maxValue];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


@end