//
//  MyPoint.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPointMath : NSObject
+(CGPoint) CGPointAdd:(const CGPoint) aPoint andPointToAdd: (const CGPoint) bPoint;
+(CGPoint) CGPointMultiplyScalar:(const CGPoint) aPoint andScalar: (const CGFloat) aScalar;
@end
