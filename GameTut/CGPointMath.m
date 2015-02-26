//
//  MyPoint.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "CGPointMath.h"

@implementation CGPointMath
+(CGPoint) CGPointAdd:(const CGPoint) aPoint andPointToAdd: (const CGPoint) bPoint
{
    return CGPointMake(aPoint.x + bPoint.x, aPoint.y + bPoint.y);
}

+(CGPoint) CGPointMultiplyScalar:(const CGPoint) aPoint andScalar: (const CGFloat) aScalar
{
    return CGPointMake(aPoint.x * aScalar, aPoint.y * aScalar);
}

@end
