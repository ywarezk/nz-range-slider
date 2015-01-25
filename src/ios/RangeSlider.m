//
//  RangeSlider.m
//  Will put a native range slider
//
//  Created by Yariv Katz on 19/11/14.
//  Updated by Eli Kushelev on 25/01/2015
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
 * display the RangeSlider on the screen
 */
- (void)showRangeSlider:(CDVInvokedUrlCommand *)command{
    //grab the params from the js
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    int maximumValue = [options integerValueForKey:@"maximumValue" defaultValue:60];
    int minimumValue = [options integerValueForKey:@"minimumValue" defaultValue:14];
    int stepValue = [options integerValueForKey:@"stepValue" defaultValue:1];
    int upperValue = [options integerValueForKey:@"upperValue" defaultValue:nil];
    int lowerValue = [options integerValueForKey:@"lowerValue" defaultValue:nil];
    
    // new params for location of placing the slider
    int leftPos = [options integerValueForKey:@"left" defaultValue:5];
    int topPos = [options integerValueForKey:@"top" defaultValue:[[UIScreen mainScreen] bounds].size.height/2];
    int sliderWidth = [options integerValueForKey:@"width" defaultValue:[[UIScreen mainScreen] bounds].size.width-10];
    int sliderHeight = [options integerValueForKey:@"height" defaultValue:100];
    
    CGRect sliderFrame = CGRectMake(leftPos, topPos, sliderWidth, sliderHeight);
    
    
    self.rangeSlider = [[NMRangeSlider alloc] initWithFrame:sliderFrame];
    [self.rangeSlider setMaximumValue:(float)maximumValue];
    [self.rangeSlider setMinimumValue:(float)minimumValue];
    [self.rangeSlider setStepValue:(float)stepValue];
    [self.rangeSlider setMinimumRange:(float)4];
    [self.rangeSlider setUpperValue:(float)maximumValue];
    [self.rangeSlider setLowerValue:(float)minimumValue];
    
    //set the default values of the slider
    if (upperValue != nil) {
        [self.rangeSlider setUpperValue:(float)upperValue];
    }
    if (lowerValue != nil) {
        [self.rangeSlider setLowerValue:(float)lowerValue];
    }
    
    //attach observers for the values of the slider
    [self.rangeSlider addObserver:self forKeyPath:@"upperValue" options:NSKeyValueObservingOptionOld context:nil];
    [self.rangeSlider addObserver:self forKeyPath:@"lowerValue" options:NSKeyValueObservingOptionOld context:nil];
    
    //attach the slider to the view
    [self.webView.superview addSubview:self.rangeSlider];
    [self.webView.superview bringSubviewToFront:self.rangeSlider];
}

/**
 * display the (single slider) UISlider on the screen
 */
- (void)showSingleSlider:(CDVInvokedUrlCommand *)command{
    //grab the params from the js
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    int maximumValue = [options integerValueForKey:@"maximumValue" defaultValue:100];
    int minimumValue = [options integerValueForKey:@"minimumValue" defaultValue:0];
    int upperValue = [options integerValueForKey:@"upperValue" defaultValue:nil];
    int lowerValue = [options integerValueForKey:@"lowerValue" defaultValue:nil];
    
    // new params for location of placing the slider
    int leftPos = [options integerValueForKey:@"left" defaultValue:5];
    int topPos = [options integerValueForKey:@"top" defaultValue:[[UIScreen mainScreen] bounds].size.height/2];
    int sliderWidth = [options integerValueForKey:@"width" defaultValue:[[UIScreen mainScreen] bounds].size.width-10];
    int sliderHeight = [options integerValueForKey:@"height" defaultValue:100];
    
    CGRect sliderFrame = CGRectMake(leftPos, topPos, sliderWidth, sliderHeight);
    
    
    self.singleSlider = [[UISlider alloc] initWithFrame:sliderFrame];
    [self.singleSlider setValue:(float)minimumValue];
    [self.singleSlider setMinimumValue:minimumValue];
    [self.singleSlider setMaximumValue:maximumValue];
    
    [self.singleSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //attach the slider to the view
    [self.webView.superview addSubview:self.singleSlider];
    [self.webView.superview bringSubviewToFront:self.singleSlider];
    
    //set the new limit values default values of the slider
    if (upperValue != nil) {
        [self.singleSlider setValue:(float)upperValue];
    }
    
}

/**
 * hides the RangeSlider from view
 */
- (void)hideRangeSlider:(CDVInvokedUrlCommand *)command{
    [self.rangeSlider removeFromSuperview];
}

/**
 * hides the SingleSlider from view
 */
- (void)hideSingleSlider:(CDVInvokedUrlCommand *)command{
    [self.singleSlider removeFromSuperview];
}


/**
 * get the lower handle of the RangeSlider
 */
- (void)getMin:(CDVInvokedUrlCommand *)command{
    int minValue = (int)[self.rangeSlider lowerValue];
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:minValue];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

/**
 * get the upper handle of the RangeSlider
 */
- (void)getMax:(CDVInvokedUrlCommand *)command{
    int maxValue = (int)[self.rangeSlider upperValue];
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:maxValue];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

/**
 * get the value of the SingleSlider
 */
- (void)getValue:(CDVInvokedUrlCommand *)command{
    int value = (int)[self.singleSlider value];
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:value];
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

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    [self writeJavascript:@"setTimeout( function() { cordova.fireDocumentEvent('singleRangeChanged') }, 0);"];
}




@end