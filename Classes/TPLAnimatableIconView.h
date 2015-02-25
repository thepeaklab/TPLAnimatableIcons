//
//  TPLAnimatableIcon.h
//  Pods
//
//  Created by Christoph Pageler on 23.02.15.
//
//

#import <UIKit/UIKit.h>
#import "TPLAnimateableIcons.h"

@interface TPLAnimatableIconView : UIView

@property (nonatomic) TPLAnimatableIconType iconType;
@property (nonatomic) TPLAnimatableIconState iconState;
@property (nonatomic) CGFloat lineWidth;

- (void)animateToState:(TPLAnimatableIconState)state;
- (void)animateToIconType:(TPLAnimatableIconType)iconType;

@end

NSString *NSStringFromTPLAnimatableIconType(TPLAnimatableIconType iconType);
