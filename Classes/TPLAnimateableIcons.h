//
//  TPLAnimateableIcons.h
//  Pods
//
//  Created by Christoph Pageler on 23.02.15.
//
//

#ifndef Pods_TPLAnimateableIcons_h
#define Pods_TPLAnimateableIcons_h

typedef NS_ENUM(NSUInteger, TPLAnimatableIconType) {
	TPLAnimatableIconTypeHamburgerToCross,
	TPLAnimatableIconTypeHamburgerToArrowLeft,
	TPLAnimatableIconTypeHamburgerToArrowRight,
	TPLAnimatableIconTypeHamburgerToArrowTop,
	TPLAnimatableIconTypeHamburgerToArrowBottom,
	TPLAnimatableIconTypeHamburgerToArrowTopRotation,
	TPLAnimatableIconTypeHamburgerToArrowBottomRotation
};

typedef NS_ENUM(NSUInteger, TPLAnimatableIconState) {
	TPLAnimatableIconState1,
	TPLAnimatableIconState2
};

typedef NS_ENUM(NSUInteger, TPLAnimatableIconLinePosition) {
	TPLAnimatableIconLinePositionTopLeft,
	TPLAnimatableIconLinePositionTopCenter,
	TPLAnimatableIconLinePositionTopRight,
	TPLAnimatableIconLinePositionMiddleLeft,
	TPLAnimatableIconLinePositionMiddleCenter,
	TPLAnimatableIconLinePositionMiddleRight,
	TPLAnimatableIconLinePositionBottomLeft,
	TPLAnimatableIconLinePositionBottomCenter,
	TPLAnimatableIconLinePositionBottomRight
};

#import "TPLAnimatableIconView.h"

#endif
