//
//  BAOARKitDemoViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/30.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOARKitDemoViewController.h"
#import <ARKit/ARKit.h>

@interface BAOARKitDemoViewController () <ARSCNViewDelegate, ARSessionDelegate>

@property (nonatomic, strong) UIView *sessionInfoView;
@property (nonatomic, strong) UILabel *sessionInfoLabel;
@property (nonatomic, strong) ARSCNView *sceneView;

@end

@implementation BAOARKitDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
    [configuration setPlaneDetection:ARPlaneDetectionVertical | ARPlaneDetectionHorizontal];
    [self.sceneView.session runWithConfiguration:configuration];
    self.sceneView.delegate = self;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.sceneView.showsStatistics = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.sceneView pause:nil];
}

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:ARPlaneAnchor.class]) {
        return;
    }

    ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
    SCNPlane *plane = [[SCNPlane alloc] init];
    plane.width = planeAnchor.extent.x;
    plane.height = planeAnchor.extent.z;
    SCNNode *planeNode = [[SCNNode alloc] init];
    planeNode.geometry = plane;
    planeNode.simdPosition = simd_make_float3(planeAnchor.center.x, 0, planeAnchor.center.z);

    planeNode.eulerAngles = SCNVector3Make(-M_PI_2, 0, 0);
    planeNode.opacity = 0.25;
    [node addChildNode:planeNode];
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:ARPlaneAnchor.class]) {
        return;
    }
    ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
    SCNNode *planeNode = node.childNodes.firstObject;
    if (![planeNode isKindOfClass:SCNPlane.class]) {
        return;
    }
    SCNPlane *plane = (SCNPlane *)planeNode.geometry;

    planeNode.simdPosition = simd_make_float3(planeAnchor.center.x, 0, planeAnchor.center.z);

    plane.width = planeAnchor.extent.x;
    plane.height = planeAnchor.extent.z;
}

#pragma mark - ARSessionDelegate

- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor *> *)anchors {
    ARFrame *frame = session.currentFrame;
    if (frame == nil) {
        return;
    }
    [self updateSessionInfoLabelForFrame:frame withTrackingState:frame.camera.trackingState];
}

- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor *> *)anchors {
    ARFrame *frame = session.currentFrame;
    if (frame == nil) {
        return;
    }
    [self updateSessionInfoLabelForFrame:frame withTrackingState:frame.camera.trackingState];
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
    [self updateSessionInfoLabelForFrame:session.currentFrame withTrackingState:camera.trackingState];
}

- (void)sessionWasInterrupted:(ARSession *)session {
    self.sessionInfoLabel.text = @"Session was interrupted";
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    self.sessionInfoLabel.text = @"Session interruption ended";
    [self resetTracking];
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    self.sessionInfoLabel.text = [NSString stringWithFormat:@"Session failed: %@", error.localizedDescription];
    [self resetTracking];
}

#pragma mark - Private Methods

- (void)updateSessionInfoLabelForFrame:(ARFrame *)frame withTrackingState:(ARTrackingState)trackingState {
    NSString *message = nil;
    switch (trackingState) {
        case ARTrackingStateNormal:
            if (frame.anchors.count == 0) {
                message = @"Move the device around to detect horizontal surfaces.";
            }
            break;
        case ARTrackingStateNotAvailable:
            message = @"Tracking unavailable";
            break;
        case ARTrackingStateLimited:
            message = @"Tracking Limited";
        default:
            break;
    }

    self.sessionInfoLabel.text = message;
    self.sessionInfoLabel.hidden = message == nil;
}

- (void)resetTracking {
    ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
}

@end
