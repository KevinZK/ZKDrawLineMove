//
//  GraphicsModel.h
//  DawingLine
//
//  Created by Zuo.Kevin on 2017/7/14.
//  Copyright © 2017年 Zuo.Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface GraphicsModel : NSObject

/**
 开始点
 */
@property(nonatomic,assign)CGPoint startPoint;

/**
 结束点
 */
@property(nonatomic,assign)CGPoint endPoint;

/**
 线颜色
 */
@property(nonatomic,strong)UIColor *lineColor;

/**
 线宽
 */
@property(nonatomic,assign)CGFloat lineWidth;

/**
 是否被选中
 */
@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,assign)BOOL isTouchStartPoint;

@property(nonatomic,assign)BOOL isTouchEndPoint;

@property(nonatomic,assign)NSInteger tag;


/**
 点击点是否在线上

 @param touchPoint 触点
 @return BOOL
 */
-(BOOL)touchPointIsContainerInModel:(CGPoint)touchPoint;

/**
 点击点是否在开始点附近

 @param touchPoint 触点
 @return BOOL
 */
-(BOOL)touchPointIsNearStartPoint:(CGPoint)touchPoint;


/**
 点击点是否在结束点附近

 @param touchPoint 触点
 @return BOOL
 */
-(BOOL)touchPointIsNearEndPoint:(CGPoint)touchPoint;

@end
