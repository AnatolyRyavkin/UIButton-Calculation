//
//  viewArea.m
//  lesson25-UIButton-Calculation
//
//  Created by Anatoly Ryavkin on 10/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVViewArea.h"

@implementation AVViewArea

- (void)drawRect:(CGRect)rect {
    self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(int i=0;i<=600;i=i+100){
       CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), self.bounds.origin.y+i);
       CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), self.bounds.origin.y+i);
    }
    for(int i=0;i<=600;i=i+150){
        if(i==150){
        CGContextMoveToPoint(context, self.bounds.origin.x+i, CGRectGetMinY(self.bounds)+100);
        CGContextAddLineToPoint(context, self.bounds.origin.x+i, CGRectGetMaxY(self.bounds)-100);
        }
        else{
            CGContextMoveToPoint(context, self.bounds.origin.x+i, CGRectGetMinY(self.bounds)+100);
            CGContextAddLineToPoint(context, self.bounds.origin.x+i, CGRectGetMaxY(self.bounds));
       }
    }
    CGContextSetLineWidth(context,1);
    CGContextSetLineCap(context,  kCGLineCapButt);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor (context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

@end
