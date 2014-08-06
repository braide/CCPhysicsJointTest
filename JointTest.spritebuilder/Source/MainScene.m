//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
{
    CCNode *_mouseClickNode, *_tagAlongNode;
    CCPhysicsNode *_physicsNode;
    CCPhysicsJoint *_testJoint;
}

- (void)didLoadFromCCB
{
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    // visualize physics bodies & joints
    _physicsNode.debugDraw = TRUE;
    
    // nothing shall collide with our invisible nodes
    _mouseClickNode.physicsBody.collisionMask = @[];
    
}


- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    _mouseClickNode.position = touchLocation;
    _tagAlongNode.position = _mouseClickNode.position;
    _tagAlongNode.physicsBody.allowsRotation = FALSE;
    _testJoint = [CCPhysicsJoint connectedPivotJointWithBodyA:_tagAlongNode.physicsBody bodyB:_mouseClickNode.physicsBody anchorA:_tagAlongNode.anchorPointInPoints];
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    _mouseClickNode.position = touchLocation;
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [_testJoint invalidate];
    NSLog(@"Joint Invalidated");
    _testJoint = nil;
    _tagAlongNode.physicsBody.allowsRotation = TRUE;
}


@end
