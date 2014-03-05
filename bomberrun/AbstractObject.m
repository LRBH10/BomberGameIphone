//
//  AbstractObject.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 26/12/12.
//
//

#import "AbstractObject.h"

@implementation AbstractObject
@synthesize current;
@synthesize postion;
@synthesize size;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin {
    current = [[Image alloc] initWithImageNamed:filename filter:GL_LINEAR subTexture:sizeAndBegin];
    postion = CGPointMake(160,240);
    size = sizeAndBegin.size;
    return self;
}

-(void)update{
    
}  
-(void)renderObject{
    
}
-(void)renderObject: (ImageRenderManager *)renderimages{
    
}

-(Boolean)colusionWith:(AbstractObject *)other{
    CGRect me = CGRectMake(postion.x-size.width/2, postion.y-size.height/2, size.width, size.height);
    CGRect oth = CGRectMake(other.postion.x, other.postion.y, other.size.width, size.height);
    return CGRectIntersectsRect(me, oth);
}
-(Boolean)colusionWithPoint:(CGPoint)other{
    CGRect me = CGRectMake(postion.x-size.width/2, postion.y-size.height/2, size.width, size.height);
    return CGRectContainsPoint(me, other);
}



-(void) playSong:(NSString *)songName withRepeatNbr:(int) nbr{
    
    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:songName,[[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops=nbr;
    [audioPlayer play];
    
}


-(void)dealloc{
    [current dealloc];
    [super dealloc];
}


@end
