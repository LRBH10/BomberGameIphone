//
//  AbstractObject.h
//  CH05_SLQTSOR
//
//  Created by Lion User on 26/12/12.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Image.h"
#import "ImageRenderManager.h"

@interface AbstractObject : NSObject
{
    Image *current;
    CGSize size;
    CGPoint postion;
     AVAudioPlayer *audioPlayer;
}
@property (nonatomic, readonly) Image *current;
@property (readwrite)    CGPoint postion;
@property (readonly)    CGSize size;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin;
-(void)update;
-(void)renderObject;
-(void)renderObject: (ImageRenderManager *)renderimages;

-(Boolean)colusionWith:(AbstractObject *)other;
-(Boolean)colusionWithPoint:(CGPoint)other;


-(void) playSong:(NSString *)songName withRepeatNbr:(int) nbr;

@end
