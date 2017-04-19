//
//  CustomLabel.m
//  Soroeru
//
//  Created by luvyoursmile on 4/6/16.
//  Copyright © 2016 soroeru.inc. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0, 13, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
