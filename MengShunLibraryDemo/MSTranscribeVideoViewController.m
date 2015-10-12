//
//  MSTranscribeVideoViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/7/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSTranscribeVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MSTranscribeVideoViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureFileOutputRecordingDelegate>{
    AVCaptureVideoDataOutput *videoOutput;
    AVCaptureAudioDataOutput *audioOutput;
    
    
    AVCaptureSession *_captureSession;
    AVCaptureDeviceInput *_captureDeviceInput;
    AVCaptureMovieFileOutput *_captureMovieFileOutput;
    AVCaptureVideoPreviewLayer *_captureVideoPreviewLayer;
    
    
}

@property (nonatomic,strong)UIButton *controlBtn;
@property (nonatomic,strong)AVAssetWriter *videoWriter;
@property (nonatomic,strong)AVAssetWriterInput *videoWriterInput;
@property (nonatomic,strong)AVAssetWriterInputPixelBufferAdaptor *adaptor;
@end

@implementation MSTranscribeVideoViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_controlBtn.enabled) {
        [_captureSession startRunning];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_controlBtn.enabled) {
        [_captureSession stopRunning];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.controlBtn];
    [self setCaptureDeviceSession];
    
    //[self start];
    
    [self addConstraints];
    
    // Do any additional setup after loading the view.
}
- (void)setCaptureDeviceSession{
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
     [_captureSession beginConfiguration];
    //获得输入设备 AVCaptureDevicePositionBack
    
    NSArray *devices=[AVCaptureDevice devices];//取得后置摄像头
    AVCaptureDevice *captureDevice = nil;
    for (captureDevice in devices) {
        if (captureDevice.position == AVCaptureDevicePositionBack) {
            break;
        }
    }
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
        _controlBtn.enabled = NO;
        return;
    }
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice=[[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备视频输入对象时出错，错误原因：%@",error.localizedDescription);
        _controlBtn.enabled = NO;
        return;
    }
    
    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        NSLog(@"取得设备音频输入对象时出错，错误原因：%@",error.localizedDescription);
        _controlBtn.enabled = NO;
        return;
    }
    
    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported ]) {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
   
    [_captureSession commitConfiguration];
    
    _captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    [_captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    _captureVideoPreviewLayer.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds),  CGRectGetHeight([UIScreen mainScreen].bounds)-64-40);
    _captureVideoPreviewLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:_captureVideoPreviewLayer];
    
    
    
    UIView *boxView = [[UIView alloc]initWithFrame:CGRectMake(60, 150, 200, 200)];
    boxView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:boxView];
    boxView.layer.masksToBounds = YES;
    boxView.layer.borderWidth = 2;
    boxView.layer.borderColor = [UIColor redColor].CGColor;
    
    
    
    
    
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"didStartRecording");
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections NS_AVAILABLE(10_7, NA){
    NSLog(@"didPauseRecording");
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didResumeRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections NS_AVAILABLE(10_7, NA)
{
    NSLog(@"didResumeRecording");
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"didFinishRecording");
}
- (void)addConstraints{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_controlBtn(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_controlBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_controlBtn(40)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_controlBtn)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_controlBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}


/*

#pragma mark - custom method

- (void)start{
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    
    if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
        
    } else {
        
    }
    [session beginConfiguration];
    
    //(查找前后摄像头)
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *deviceAV = nil;
    for (AVCaptureDevice *device in devices) {
        NSLog(@"Device name: %@", [device localizedName]);
        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                deviceAV = device;
            }
            else {
                NSLog(@"Device position : front");
            }
        }
    }
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:deviceAV error:&error];
    [session addInput:input];
    
    
    
    [session commitConfiguration];
    
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    
    
    previewLayer.frame = CGRectMake(0, 44, 320, 480);
    previewLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:previewLayer];
    
    
    [session startRunning];
}
*/

#pragma mark - delegate method

-(void)captureOutput:(AVCaptureOutput*)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection*)connection{


}
 
#pragma mark - response method
- (void)changeBtnState:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    if (![_captureMovieFileOutput isRecording]) {
        //预览图层和视频方向保持一致
        captureConnection.videoOrientation=[_captureVideoPreviewLayer connection].videoOrientation;
        NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"];
        NSLog(@"save path is :%@",outputFielPath);
        NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
        [_captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
    }
    else{
        [_captureMovieFileOutput stopRecording];//停止录制
    }
    
    
    
    
}


#pragma mark - setter or getter method

- (UIButton *)controlBtn{
    if (!_controlBtn) {
        _controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_controlBtn setTitle:@"录制" forState:normal];
        [_controlBtn setTitle:@"停止" forState:UIControlStateSelected];
        [_controlBtn setTitle:@"不可用" forState:UIControlStateDisabled];
        [_controlBtn setTitleColor:[UIColor blackColor] forState:normal];
        [_controlBtn addTarget:self action:@selector(changeBtnState:) forControlEvents:UIControlEventTouchUpInside];
        _controlBtn.backgroundColor = [UIColor greenColor];
        _controlBtn.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _controlBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
