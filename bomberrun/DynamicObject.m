//
//  DynamicObject.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 03/01/13.
//
//

#import "DynamicObject.h"
#include <stdlib.h>

@implementation DynamicObject

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr{
    
    nbrOfImage = nbr;
    begin = sizeAndBegin.origin;
    size = sizeAndBegin.size;
    nbrcurrent = 0;
    
    image = [[Image alloc] initWithImageNamed:filename filter:GL_LINEAR];
    current = [image subImageInRect:CGRectMake(begin.x, begin.y, size.width, size.height)];
    
    int x = arc4random()%250+15;
    int y = arc4random()%400+40;

    
    postion = CGPointMake(x,y);
    
    return self;
}

-(void)update{
    
}

-(void) renderObject{
}
-(void) death:(CGRect)begindeath withNumber:(int)nbr{
    
}

-(void)dealloc{
    [image dealloc];
    [super dealloc];
}

@end
