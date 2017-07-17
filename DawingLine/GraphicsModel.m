//
//  GraphicsModel.m
//  DawingLine
//
//  Created by Zuo.Kevin on 2017/7/14.
//  Copyright © 2017年 Zuo.Kevin. All rights reserved.
//

#import "GraphicsModel.h"

@implementation GraphicsModel

-(instancetype)init{
    if (self = [super init]) {
        _isSelected = false;
        _lineColor = [UIColor blackColor];
        _lineWidth = 3.0f;
    }
    return self;
}

-(BOOL)touchPointIsContainerInModel:(CGPoint)touchPoint{
    
    return distanceFromPointToLineSegment(_startPoint, _endPoint, touchPoint) < 10.0f;
    
}


-(BOOL)touchPointIsNearStartPoint:(CGPoint)touchPoint{
    
    return distanceBetweenTwoPoints(_startPoint, touchPoint) < 5.0f;
    
}

-(BOOL)touchPointIsNearEndPoint:(CGPoint)touchPoint{
    return distanceBetweenTwoPoints(_endPoint, touchPoint) < 5.0f;
}

float distanceBetweenTwoPoints(CGPoint a, CGPoint b) {
    float dx = b.x - a.x;
    float dy = b.y - a.y;
    
    return sqrtf(dx * dx + dy * dy);
}

float lengthSquared(CGPoint a, CGPoint b) {
    return distanceBetweenTwoPoints(a, b) * distanceBetweenTwoPoints(a, b);
}

float dotProductOfTwoPoints(CGPoint a, CGPoint b) {
    return a.x * b.x + a.y * b.y;
}


CGPoint subtractVector(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

CGPoint addVector(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

CGPoint multiplyVectorByScalar(CGPoint a, float f) {
    return CGPointMake(f * a.x, f* a.y);
}



float distanceFromPointToLineSegment(CGPoint a, CGPoint b, CGPoint p) {
    float l2 = lengthSquared(a, b);
    
    if(l2 == 0.0f)
        return distanceBetweenTwoPoints(p, a);
    
    float t = dotProductOfTwoPoints(subtractVector(p, a), subtractVector(b, a)) / l2;
    
    if(t < 0.0f)
        return distanceBetweenTwoPoints(p, a);
    else if(t > 1.0f)
        return distanceBetweenTwoPoints(p, b);
    
    CGPoint projection = addVector(a, multiplyVectorByScalar(subtractVector(b, a), t));
    
    return distanceBetweenTwoPoints(p, projection);
}


@end
