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

@interface RangeSlider ()
{
    BOOL _showHandelCaptions;
}
@end

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
    
    _showHandelCaptions = [options integerValueForKey:@"showCaptions" defaultValue:false];
    
    CGRect sliderFrame = CGRectMake(leftPos, topPos, sliderWidth, sliderHeight);
    
    
    self.rangeSlider = [[NMRangeSlider alloc] initWithFrame:sliderFrame];
    [self.rangeSlider setMaximumValue:(float)maximumValue];
    [self.rangeSlider setMinimumValue:(float)minimumValue];
    [self.rangeSlider setStepValue:(float)stepValue];
    [self.rangeSlider setMinimumRange:(float)4];
    [self.rangeSlider setUpperValue:(float)maximumValue];
    [self.rangeSlider setLowerValue:(float)minimumValue];
    
    //change the color of slider track
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    UIColor *color = [UIColor colorWithRed:229.0f/255.0f green:46.0f/255.0f blue:91.0f/255.0f alpha:1.0];
    [color setFill];
    UIRectFill(rect); // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.rangeSlider setTrackImage:image];
    
    //set the default values of the slider
    if (upperValue != nil) {
        [self.rangeSlider setUpperValue:(float)upperValue];
    }
    if (lowerValue != nil) {
        [self.rangeSlider setLowerValue:(float)lowerValue];
    }
    
    if(_showHandelCaptions==YES){
        CGPoint point = CGPointMake(16.0, 14.0);
        UIImage *temp = [self drawText:@"14" inImage:[self.rangeSlider lowerHandleImageNormal]  atPoint:point];
        [self.rangeSlider setLowerHandleImageNormal:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        [self.rangeSlider setLowerHandleImageHighlighted:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        temp = [self drawText:@"60" inImage:[self.rangeSlider upperHandleImageNormal] atPoint:point];
        [self.rangeSlider setUpperHandleImageNormal:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        [self.rangeSlider setUpperHandleImageHighlighted:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        
    }
    
    //attach observers for the values of the slider
    [self.rangeSlider addObserver:self forKeyPath:@"upperValue" options:NSKeyValueObservingOptionNew context:nil];
    [self.rangeSlider addObserver:self forKeyPath:@"lowerValue" options:NSKeyValueObservingOptionNew context:nil];
    
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
    
    //change the color of slider track
    UIColor *color = [UIColor colorWithRed:229.0f/255.0f green:46.0f/255.0f blue:91.0f/255.0f alpha:1.0];
    [self.singleSlider setMinimumTrackTintColor:color];
    
    
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
    [self.rangeSlider removeObserver:self forKeyPath:@"upperValue" context:nil];
    [self.rangeSlider removeObserver:self forKeyPath:@"lowerValue" context:nil];
    
    [self.rangeSlider removeFromSuperview];
}

/**
 * hides the SingleSlider from view
 */
- (void)hideSingleSlider:(CDVInvokedUrlCommand *)command{
    [self.singleSlider removeTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
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
    
    if(_showHandelCaptions==YES){
        //creating new handle image
        NSNumber *n = [change valueForKey:@"new"];
        CGPoint point = CGPointMake(16.0, 14.0);
        UIImage *temp = [self drawText:[n stringValue] inImage:[UIImage imageNamed:@"slider-default7-handle"] atPoint:point];
        
        if([keyPath isEqualToString:@"lowerValue"]){
            [self.rangeSlider setLowerHandleImageNormal:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
            [self.rangeSlider setLowerHandleImageHighlighted:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        }else{
            [self.rangeSlider setUpperHandleImageNormal:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
            [self.rangeSlider setUpperHandleImageHighlighted:[temp imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 8, 1, 8)]];
        }
    }
    
    [self writeJavascript:@"setTimeout( function() { cordova.fireDocumentEvent('rangeChanged') }, 0);"];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    [self writeJavascript:@"setTimeout( function() { cordova.fireDocumentEvent('singleRangeChanged') }, 0);"];
}


/**
 *  Generate new handle image helper
 */
-(UIImage *) drawText:(NSString*) text inImage:(UIImage*)image atPoint:(CGPoint)point
{
    UIFont *font = [UIFont fontWithName:@"Times New Roman" size:12.0];
    CGRect rect = CGRectMake(0, 0, 45, 45);
    
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:CGRectMake(0,0,rect.size.width,rect.size.height)];
    
    CGRect rect2 = CGRectMake(point.x,point.y,20, 20);
    UILabel *lblText = [[UILabel alloc] init];
    [lblText setTextColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0]];
    [lblText.textColor set];
    
    [text drawInRect:CGRectIntegral(rect2) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end