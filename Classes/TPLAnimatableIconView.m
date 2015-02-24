//
//  TPLAnimatableIcon.m
//  Pods
//
//  Created by Christoph Pageler on 23.02.15.
//
//

#import "TPLAnimatableIconView.h"

@interface TPLAnimatableIconView()
{
	BOOL _didLayout;
}

@property (strong, nonatomic) NSArray *strokes;

@end

@implementation TPLAnimatableIconView

#pragma mark - Init

- (instancetype)init
{
	if (self = [super init]) {
		[self generalInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self generalInit];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self generalInit];
	}
	return self;
}

- (void)generalInit
{
	_didLayout = NO;
	
	_strokeWidth = 4;
	_iconType = TPLAnimatableIconTypeHamburgerToCross;
	_iconState = TPLAnimatableIconState1;
	
//	CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
//	shapeLayer.strokeColor = self.tintColor.CGColor;
//	shapeLayer.fillColor = [UIColor clearColor].CGColor;
//	shapeLayer.lineWidth = self.strokeWidth;
//	shapeLayer.path = [self pathForCurrentIcon];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	_didLayout = YES;
	
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:YES];
}

#pragma mark - Setter

- (void)setIconType:(TPLAnimatableIconType)iconType
{
	_iconType = iconType;
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:YES];
}

- (void)setIconState:(TPLAnimatableIconState)iconState
{
	[self animateToState:iconState
				animated:NO
		  updateIconType:NO];
}

- (void)setStrokeWidth:(CGFloat)strokeWidth
{
	_strokeWidth = strokeWidth;
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:NO];
}

#pragma mark - Public Methods

- (void)animateToState:(TPLAnimatableIconState)state
{
	[self animateToState:state
				animated:YES
		  updateIconType:NO];
}

#pragma mark - Animations

- (void)animateToState:(TPLAnimatableIconState)state
			  animated:(BOOL)animated
		updateIconType:(BOOL)updateIconType
{
	_iconState = state;
	
	if (!_didLayout) { return; }
	if (updateIconType) {
		
		// remove all old layers
		for (CAShapeLayer *shapeLayer in self.strokes) {
			[shapeLayer removeFromSuperlayer];
		}
		
		// create new layers for current iconType
		switch (self.iconType) {
			case TPLAnimatableIconTypeHamburgerToCross:
			{
				self.strokes = @[
								 [[CAShapeLayer alloc] init],
								 [[CAShapeLayer alloc] init],
								 [[CAShapeLayer alloc] init]
								 ];
				break;
			}
			case TPLAnimatableIconTypeHamburgerToArrowLeft:
			{
				self.strokes = @[
								 [[CAShapeLayer alloc] init],
								 [[CAShapeLayer alloc] init],
								 [[CAShapeLayer alloc] init]
								 ];
				break;
			}
			default:
			{
				self.strokes = nil;
			}
		}
		
		// add new layers to views' layer
		for (CAShapeLayer *shapeLayer in self.strokes) {
			[self.layer addSublayer:shapeLayer];
		}
	}
	
	// update non animatable properties
	for (CAShapeLayer *shapeLayer in self.strokes) {
		shapeLayer.lineWidth = self.strokeWidth;
		
		shapeLayer.strokeColor = self.tintColor.CGColor;
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
		
		shapeLayer.lineCap = kCALineCapRound;
	}
	
	
	// update animatable properties
	void(^animationsBlock)(CAShapeLayer *, NSInteger, CGRect) = ^(CAShapeLayer *shapeLayer,
																  NSInteger idx,
																  CGRect b)
	{
		
		CGPoint lineFromPoint, lineToPoint;
		
		CGPoint pointTopLeft = CGPointMake(b.origin.x, b.origin.y);
		CGPoint pointTopRight = CGPointMake(b.origin.x + b.size.width, b.origin.y);
		
		CGPoint pointMiddleLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height / 2);
		CGPoint pointMiddleRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height / 2);
		
		CGPoint pointBottomLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height);
		CGPoint pointBottomRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height);
		
		switch (self.iconType) {
			case TPLAnimatableIconTypeHamburgerToCross:
			{
				
				switch (idx) {
					case 0:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointTopLeft : pointBottomLeft;
						lineToPoint = pointTopRight;
						
						shapeLayer.opacity = 1;
						break;
					}
					case 1:
					{
						lineFromPoint = pointMiddleLeft;
						lineToPoint = pointMiddleRight;
						
						shapeLayer.opacity = self.iconState == TPLAnimatableIconState1 ? 1 : 0;
						break;
					}
					case 2:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomLeft : pointTopLeft;
						lineToPoint = pointBottomRight;
						
						shapeLayer.opacity = 1;
						break;
					}
				}
				
				break;
			}
			case TPLAnimatableIconTypeHamburgerToArrowLeft:
			{
				break;
			}
			default:
			{
				
				break;
			}
		}
		
		UIBezierPath *shapeLayerPath = [UIBezierPath bezierPath];
		[shapeLayerPath moveToPoint:lineFromPoint];
		[shapeLayerPath addLineToPoint:lineToPoint];
		
		shapeLayer.path = shapeLayerPath.CGPath;
		
	};
	
	// Find inner bounding H = W
	CGFloat l = MIN(self.frame.size.width, self.frame.size.height);
	CGSize s = CGSizeMake(l, l);
	

	
	// Different aspect rations for states
	// ... hamburger H != W, Cross H == W
	
	// 0.5 -> height/2 == width
	CGFloat aspectRatio = 1;
	
	switch (self.iconType) {
		case TPLAnimatableIconTypeHamburgerToCross:
		{
			aspectRatio = self.iconState == TPLAnimatableIconState1 ? 0.6 : 1;
			break;
		}
		case TPLAnimatableIconTypeHamburgerToArrowLeft:
		{
			aspectRatio = self.iconState == 0.6;
			break;
		}
	}
	
	// apply aspect ratio
	s.height *= aspectRatio;
	
	
	
	// Different scales for states
	CGFloat scale = 1;
	
	switch (self.iconType) {
		case TPLAnimatableIconTypeHamburgerToCross:
		{
			scale = self.iconState == TPLAnimatableIconState1 ? 1 : 0.8;
			break;
		}
		case TPLAnimatableIconTypeHamburgerToArrowLeft:
		{
			scale = 1;
			break;
		}
	}
	
	// apply scale
	s.height *= scale;
	s.width *= scale;
	
	
	// re-center bounds
	CGRect innerBounds = CGRectMake(self.frame.size.width / 2 - s.width / 2,
									self.frame.size.height / 2 - s.height / 2,
									s.width, s.height);
	
	
	if (animated) {
		
		[self.strokes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			
			CAShapeLayer *shapeLayer = obj;
			
			// Opacity animation
			CABasicAnimation *shapeLayerOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
			shapeLayerOpacityAnimation.duration = 0.3;
			shapeLayerOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
			shapeLayerOpacityAnimation.fromValue = @(((CAShapeLayer *)shapeLayer.presentationLayer).opacity);
			
			// Path animation
			CABasicAnimation *shapeLayerPathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
			shapeLayerPathAnimation.duration = 0.3;
			shapeLayerPathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
			shapeLayerPathAnimation.fromValue = (__bridge id)(((CAShapeLayer *)shapeLayer.presentationLayer).path);
			
			animationsBlock(obj, idx, innerBounds);
			
			// Opacity
			shapeLayerOpacityAnimation.toValue = @(shapeLayer.opacity);
			[shapeLayer addAnimation:shapeLayerOpacityAnimation forKey:@"opacity"];
			
			// Path
			shapeLayerPathAnimation.toValue = (__bridge id)(shapeLayer.path);
			[shapeLayer addAnimation:shapeLayerPathAnimation forKey:@"path"];
		}];
		
		
	} else {
		[self.strokes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			animationsBlock(obj, idx, innerBounds);
		}];
	}
}

@end
