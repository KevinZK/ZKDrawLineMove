//
//  DrawingBoardView.m
//  DawingLine
//
//  Created by Zuo.Kevin on 2017/7/14.
//  Copyright © 2017年 Zuo.Kevin. All rights reserved.
//

#import "DrawingBoardView.h"
#import "GraphicsModel.h"
#define SELECTMARGIN 10.0f
@interface DrawingBoardView ()

@property(nonatomic,strong)NSMutableArray<GraphicsModel*> *dataArr;

@property(nonatomic,strong)GraphicsModel *model;

@property(nonatomic,assign)NSInteger currentTag;

@property(nonatomic,assign)CGPoint saveStartPoint;

@property(nonatomic,assign)CGPoint saveEndPoint;

@property(nonatomic,strong)GraphicsModel *currentModel;


@end

@implementation DrawingBoardView

-(NSMutableArray<GraphicsModel *> *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    
    return _dataArr;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.saveStartPoint = CGPointMake(0, 0);
        self.saveEndPoint = CGPointMake(0, 0);
        
        self.currentModel = [[GraphicsModel alloc]init];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.dataArr.count <= 0) return;
    
    for (GraphicsModel *shape in self.dataArr) {
        if (shape.isSelected) {
            
            UIColor* aColor = [UIColor blueColor];
            CGContextSetFillColorWithColor(context, aColor.CGColor);
            CGContextAddArc(context, shape.startPoint.x, shape.startPoint.y, 4.0, 0, M_PI * 2, YES);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
            
            
            CGContextSetFillColorWithColor(context, aColor.CGColor);
            CGContextAddArc(context, shape.endPoint.x, shape.endPoint.y, 4.0, 0, M_PI * 2, YES);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
            
            
        }
        
        [self drawLine:shape ref:context];
        
        
    }
    
    
    
}

-(void)drawLine:(GraphicsModel*)model ref:(CGContextRef)context{
    if (model.endPoint.x == 0.0 && model.endPoint.y == 0.0) return;
    if (model.startPoint.x == 0.0 && model.startPoint.y == 0.0) return;
    CGContextSetLineWidth(context, model.lineWidth);
    CGContextSetStrokeColorWithColor(context, model.lineColor.CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, model.startPoint.x, model.startPoint.y);
    CGContextAddLineToPoint(context, model.endPoint.x, model.endPoint.y);
    CGContextStrokePath(context);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint startPoint = [touch locationInView:self];
    self.currentModel.startPoint = startPoint;
//    NSLog(@"startPoint : x = %f , y = %f",startPoint.x,startPoint.y);
    
    NSInteger touchesBeganSelectedIndex = -1;
    
    if (self.dataArr.count > 0) {
        for (GraphicsModel *model in [_dataArr reverseObjectEnumerator]) {
            if ([model touchPointIsContainerInModel:startPoint]) {
                touchesBeganSelectedIndex = [_dataArr indexOfObject:model];
                [self clearSelectedStatus];
                model.isSelected = TRUE;
                self.currentTag  = touchesBeganSelectedIndex + 1000;
                self.saveStartPoint = model.startPoint;
                self.saveEndPoint   = model.endPoint;
                if ([model touchPointIsNearStartPoint:startPoint]) {

                    _model.isTouchStartPoint = YES;
                }else if([model touchPointIsNearEndPoint:startPoint]){

                    _model.isTouchEndPoint = YES;
                }else{

                    _model.isTouchEndPoint = _model.isTouchStartPoint = NO;
                }
                
                break;
            }
        }
    }
    if (touchesBeganSelectedIndex == -1) {
        self.model = [[GraphicsModel alloc]init];
        self.currentTag = self.model.tag = 1000 + self.dataArr.count;
        self.model.startPoint = startPoint;
        [self.dataArr addObject:self.model];
        [self clearSelectedStatus];
    }
    
    
}

-(void)clearSelectedStatus{
    for (GraphicsModel *model in _dataArr) {
        model.isSelected = FALSE;
        model.isTouchEndPoint = model.isTouchStartPoint = NO;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint endPoint = [touch locationInView:self];
    self.currentModel.endPoint = endPoint;
//    NSLog(@"endPoint : x = %f , y = %f",endPoint.x,endPoint.y);

    GraphicsModel *shape = [_dataArr objectAtIndex:self.currentTag - 1000];
    
    if (shape.isSelected) {
        
        if (shape.isTouchStartPoint) {
            shape.startPoint = endPoint;
        }else if (shape.isTouchEndPoint){
            shape.endPoint  = endPoint;
        }else{
            float dx = _currentModel.endPoint.x - _currentModel.startPoint.x,
            dy = _currentModel.endPoint.y - _currentModel.startPoint.y;
            
            shape.startPoint = CGPointMake(self.saveStartPoint.x + dx, self.saveStartPoint.y + dy);
            shape.endPoint = CGPointMake(self.saveEndPoint.x + dx, self.saveEndPoint.y + dy);
        }
        
        
    }else{
        
        shape.endPoint = endPoint;
    }
    
    
    [self setNeedsDisplay];
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    for (GraphicsModel *model in _dataArr) {
        if (model.endPoint.x == 0.0 && model.endPoint.y == 0.0) {
            [_dataArr removeObject:model];
        }
    }
    [self setNeedsDisplay];
}

@end
