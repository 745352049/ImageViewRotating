//
//  ViewController.m
//  ImageViewRotating
//
//  Created by iOS开发 on 2020/6/24.
//  Copyright © 2020 陕西文投教育科技有限公司. All rights reserved.
//

#import "ViewController.h"

#import "YTRotatingImageView.h"

#import "YTRotatingView.h"

@interface ViewController () <CAAnimationDelegate>

@property (nonatomic, strong) YTRotatingImageView *imageV;
@property (nonatomic, strong) YTRotatingView *rotateView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageV.frame = CGRectMake(100, 40, 200, 200);
    self.imageV.layer.cornerRadius = 100;
    [self.view addSubview:self.imageV];
    self.imageV.isResetWithResume = YES;
    [self.imageV startRotatingWithAngle:M_PI*2.0 Duration:2.0 RepeatCount:4];
    self.imageV.rotatingCompleteBlock = ^(YTRotatingImageView * _Nonnull rotatingImageView) {
        NSLog(@"YTRotatingImageView 旋转完成");
    };
    
    [self.view addSubview:self.rotateView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    imageView.frame = self.rotateView.bounds;
    [self.rotateView addSubview:imageView];
    [self.rotateView startRotatingWithAngle:M_PI*2.0 Duration:2.0 RepeatCount:4];
    self.rotateView.rotatingCompleteBlock = ^(YTRotatingView * _Nonnull rotatingView) {
        NSLog(@"YTRotatingView 旋转完成");
    };
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, CGRectGetMaxY(self.rotateView.frame) + 20)];
    [path addLineToPoint:CGPointMake(400, CGRectGetMaxY(self.rotateView.frame) + 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 4.0;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.fillColor = nil;
    layer.strokeStart = 0;
    layer.strokeEnd = 1;
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineJoinRound;
    
    self.shapeLayer = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    [animation setValue:@"1" forKey:@"2"];
    [layer addAnimation:animation forKey:@"removeRippleLayer"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([self.shapeLayer animationForKey:@"removeRippleLayer"] == anim) {
        NSLog(@"removeRippleLayer 1");
    }
    // 或者
    if([[anim valueForKey:@"2"] isEqualToString:@"1"]) {
        NSLog(@"removeRippleLayer 2");
        self.shapeLayer.lineWidth = 8.0;
        self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        
        [self.shapeLayer addAnimation:[self opacityForever_Animation:2] forKey:nil];
    }
}

- (CABasicAnimation *)opacityForever_Animation:(float)time {
    // 必须写opacity才行
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    // 这是透明度
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 没有的话是均匀的动画
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.imageV.isRotateState ? @"YES" : @"NO");
    NSLog(@"%@", self.imageV.isPauseState ? @"YES" : @"NO");
    NSLog(@"%@", self.imageV.isStopState ? @"YES" : @"NO");
}

- (IBAction)pause:(UIButton *)sender {
    [self.imageV pauseRotating];
    [self.rotateView pauseRotating];
}

- (IBAction)resume:(UIButton *)sender {
    [self.imageV resumeRotating];
    [self.rotateView resumeRotating];
}

- (IBAction)stop:(UIButton *)sender {
    [self.imageV stopRotating];
    [self.rotateView stopRotating];
}

- (IBAction)start:(UIButton *)sender {
    [self.imageV startRotating];
    [self.rotateView startRotating];
}

- (YTRotatingView *)rotateView {
    if (!_rotateView) {
        _rotateView = [[YTRotatingView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.imageV.frame) + 20, 100, 100)];
        _rotateView.backgroundColor = [UIColor blueColor];
        _rotateView.layer.cornerRadius = 50;
        _rotateView.clipsToBounds = YES;
    }
    return _rotateView;
}

- (YTRotatingImageView *)imageV {
    if (!_imageV) {
        _imageV = [[YTRotatingImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
    }
    return _imageV;
}

@end
