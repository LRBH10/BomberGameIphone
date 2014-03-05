//
//  DynamicObject.h
//  CH05_SLQTSOR
//
//  Created by Lion User on 03/01/13.
//
//

#import "AbstractObject.h"

@interface DynamicObject : AbstractObject{
    Image *image;
    CGPoint begin;
    int nbrOfImage;
    int nbrcurrent;
}
-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr;
-(void)death:(CGRect) begindeath withNumber:(int)nbr;

@end
