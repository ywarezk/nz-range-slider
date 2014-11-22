//
//  RangeSlider.h
//  put a native range slider in a cordova app
//
//  Created by Yariv Katz on 19/11/14.
//  Copyright (c) 2014 Nerdz LTD All rights reserved.
//  Website: http://www.nerdeez.com
//

#import <Cordova/CDV.h>
#import "NMRangeSlider.h"

@interface RangeSlider : CDVPlugin{
    NMRangeSlider* rangeSlider;
}

@property(nonatomic, retain) NMRangeSlider* rangeSlider;

- (void)showSlider:(CDVInvokedUrlCommand *)command;
- (void)hideSlider:(CDVInvokedUrlCommand *)command;
- (void)getMin:(CDVInvokedUrlCommand *)command;
- (void)getMax:(CDVInvokedUrlCommand *)command;


@end