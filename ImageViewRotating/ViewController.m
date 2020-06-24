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

@interface ViewController ()

@property (nonatomic, strong) YTRotatingImageView *imageV;
@property (nonatomic, strong) YTRotatingView *rotateView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageV.frame = CGRectMake(100, 40, 200, 200);
    self.imageV.layer.cornerRadius = 100;
    [self.view addSubview:self.imageV];
    self.imageV.isResetWithResume = YES;
    [self.imageV startRotatingWithAngle:M_PI*2.0 Duration:5.0 RepeatCount:MAXFLOAT];
    
    [self.view addSubview:self.rotateView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    imageView.frame = self.rotateView.bounds;
    [self.rotateView addSubview:imageView];
    [self.rotateView startRotatingWithAngle:M_PI*2.0 Duration:4.0 RepeatCount:5];
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
