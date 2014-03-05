//
//  StaticObject.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 03/01/13.
//
//

#import "StaticObject.h"

@implementation StaticObject
-(void)renderObject: (ImageRenderManager *)renderimages{
    [current renderCenteredAtPoint:postion];
    [renderimages renderImages];
}
@end
