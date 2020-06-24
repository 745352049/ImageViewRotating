//
//  ViewController.m
//  ImageViewRotating
//
//  Created by iOS开发 on 2020/6/24.
//  Copyright © 2020 陕西文投教育科技有限公司. All rights reserved.
//

#import "ViewController.h"

#import "YTRotatingImageView.h"

@interface ViewController ()

@property (nonatomic, strong) YTRotatingImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageV.frame = CGRectMake(100, 100, 200, 200);
    self.imageV.layer.cornerRadius = 100;
    [self.view addSubview:self.imageV];
    self.imageV.isResetWithResume = YES;
    [self.imageV startRotatingWithAngle:M_PI*2.0 Duration:5.0 RepeatCount:MAXFLOAT];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.imageV.isRotateState ? @"YES" : @"NO");
    NSLog(@"%@", self.imageV.isPauseState ? @"YES" : @"NO");
    NSLog(@"%@", self.imageV.isStopState ? @"YES" : @"NO");
}

- (IBAction)pause:(UIButton *)sender {
    [self.imageV pauseRotating];
}

- (IBAction)resume:(UIButton *)sender {
    [self.imageV resumeRotating];
}

- (IBAction)stop:(UIButton *)sender {
    [self.imageV stopRotating];
}

- (IBAction)start:(UIButton *)sender {
    [self.imageV startRotating];
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
