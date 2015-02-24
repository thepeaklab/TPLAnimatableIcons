//
//  TPLAnimatableIcon.m
//  Pods
//
//  Created by Christoph Pageler on 23.02.15.
//
//

#import "TPLAnimatableIconView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface TPLAnimatableIconView()
{
	BOOL _didLayout;
}

@property (strong, nonatomic) NSDictionary *iconTypeSettings;
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
	
	_lineWidth = 4;
	_iconType = TPLAnimatableIconTypeHamburgerToCross;
	_iconState = TPLAnimatableIconState1;
	
	self.iconTypeSettings = @{
							  @(TPLAnimatableIconTypeHamburgerToCross): @{
									  @"numberOfStrokes": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
												  @(TPLAnimatableIconState2)
											   }
									  ]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowLeft): @{
									  @"numberOfStrokes": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  }
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowTopRotation): @{
									  @"numberOfStrokes": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(90)
									  }
							  }
	};
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

- (void)setLineWidth:(CGFloat)lineWidth
{
	_lineWidth = lineWidth;
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

#pragma mark - Settings

- (NSDictionary *)settingsForIconType:(TPLAnimatableIconType)iconType
{
	return self.iconTypeSettings[@(iconType)];
}

- (NSInteger)numberOfStrokesForIconType:(TPLAnimatableIconType)iconType
{
	return [[self settingsForIconType:iconType][@"numberOfStrokes"] integerValue];
}

- (CGFloat)aspectRationForIconType:(TPLAnimatableIconType)iconType
						 iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"aspectRatio"][@(iconState)] doubleValue];
}

- (CGFloat)scaleForIconType:(TPLAnimatableIconType)iconType
				  iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"scale"][@(iconState)] doubleValue];
}

- (CGFloat)rotationForIconType:(TPLAnimatableIconType)iconType
					 iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"rotation"][@(iconState)] doubleValue];
}

#pragma mark - Animations

- (void)animateToState:(TPLAnimatableIconState)state
			  animated:(BOOL)animated
		updateIconType:(BOOL)updateIconType
{
	_iconState = state;
	
	if (!_didLayout) { return; }
	if (updateIconType) {
		
		#warning maybe we dont need to remove old strokes if new count == oldCount
		// remove all old layers
		for (CAShapeLayer *shapeLayer in self.strokes) {
			[shapeLayer removeFromSuperlayer];
		}
		
		// create new layers for current iconType
		NSMutableArray *mutableStrokes = [NSMutableArray array];
		for (int i = 0; i < [self numberOfStrokesForIconType:self.iconType]; i++) {
			[mutableStrokes addObject:[[CAShapeLayer alloc] init]];
		}
		self.strokes = [NSArray arrayWithArray:mutableStrokes];
		mutableStrokes = nil;
		
		// add new layers to views' layer
		for (CAShapeLayer *shapeLayer in self.strokes) {
			[self.layer addSublayer:shapeLayer];
		}
	}
	
	// update non animatable properties
	for (CAShapeLayer *shapeLayer in self.strokes) {
		shapeLayer.lineWidth = self.lineWidth;
		
		shapeLayer.strokeColor = self.tintColor.CGColor;
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
		
		shapeLayer.lineCap = kCALineCapRound;
	}
	
	// update animatable properties
	void(^lineAnimationsBlock)(CAShapeLayer *, NSInteger, CGRect) = ^(CAShapeLayer *shapeLayer,
																  NSInteger idx,
																  CGRect b)
	{
		
		CGPoint lineFromPoint, lineToPoint;
		
		CGPoint pointTopLeft = CGPointMake(b.origin.x, b.origin.y);
		CGPoint pointTopCenter = CGPointMake(b.origin.x + b.size.width /  2, b.origin.y);
		CGPoint pointTopRight = CGPointMake(b.origin.x + b.size.width, b.origin.y);
		
		CGPoint pointMiddleLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height / 2);
		CGPoint pointMiddleRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height / 2);
		
		CGPoint pointBottomLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height);
		CGPoint pointBottomCenter = CGPointMake(b.origin.x + b.size.width / 2, b.origin.y + b.size.height);
		CGPoint pointBottomRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height);
		
		CGFloat opacity = 0;
		
#warning handle with stroke dict
		
		switch (self.iconType) {
			case TPLAnimatableIconTypeHamburgerToCross:
			{
				switch (idx) {
					case 0:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointTopLeft : pointBottomLeft;
						lineToPoint = pointTopRight;
						
						opacity = 1;
						break;
					}
					case 1:
					{
						lineFromPoint = pointMiddleLeft;
						lineToPoint = pointMiddleRight;
						
						opacity = self.iconState == TPLAnimatableIconState1 ? 1 : 0;
						break;
					}
					case 2:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomLeft : pointTopLeft;
						lineToPoint = pointBottomRight;
						
						opacity = 1;
						break;
					}
				}
				
				break;
			}
			case TPLAnimatableIconTypeHamburgerToArrowLeft:
			{
				switch (idx) {
					case 0:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointTopLeft : pointMiddleLeft;
						lineToPoint = self.iconState == TPLAnimatableIconState1 ? pointTopRight : pointTopCenter;
						
						opacity = 1;
						break;
					}
					case 1:
					{
						lineFromPoint = pointMiddleLeft;
						lineToPoint = pointMiddleRight;
						
						opacity = 1;
						break;
					}
					case 2:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomLeft : pointMiddleLeft;
						lineToPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomRight : pointBottomCenter;
						
						opacity = 1;
						break;
					}
				}
				break;
			}
			case TPLAnimatableIconTypeHamburgerToArrowTopRotation:
			{
				switch (idx) {
					case 0:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointTopLeft : pointMiddleLeft;
						lineToPoint = self.iconState == TPLAnimatableIconState1 ? pointTopRight : pointTopCenter;
						
						opacity = 1;
						break;
					}
					case 1:
					{
						lineFromPoint = pointMiddleLeft;
						lineToPoint = pointMiddleRight;
						
						opacity = 1;
						break;
					}
					case 2:
					{
						lineFromPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomLeft : pointMiddleLeft;
						lineToPoint = self.iconState == TPLAnimatableIconState1 ? pointBottomRight : pointBottomCenter;
						
						opacity = 1;
						break;
					}
				}
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
		shapeLayer.opacity = opacity;
		
	};
	
	void(^layerAnimationsBlock)(void) = ^(void) {
		
		CGFloat rotation = [self rotationForIconType:self.iconType
										   iconState:self.iconState];
		
		[self.layer setValue:@(DEGREES_TO_RADIANS(rotation))
				  forKeyPath:@"transform.rotation.z"];
		
	};
	
	// Find inner bounding H = W
	CGFloat l = MIN(self.frame.size.width, self.frame.size.height);
	CGSize s = CGSizeMake(l, l);
	

	
	// Different aspect rations for states
	// ... hamburger H != W, Cross H == W
	
	// 0.5 -> height/2 == width
	CGFloat aspectRatio = [self aspectRationForIconType:self.iconType
											  iconState:self.iconState];
	
	// apply aspect ratio
	s.height *= aspectRatio;
	
	
	// Different scales for states
	CGFloat scale = [self scaleForIconType:self.iconType
								 iconState:self.iconState];
	
	// apply scale
	s.height *= scale;
	s.width *= scale;
	
	
	// re-center bounds
	CGRect innerBounds = CGRectMake(self.frame.size.width / 2 - s.width / 2,
									self.frame.size.height / 2 - s.height / 2,
									s.width, s.height);
	
	
	if (animated) {
		
		CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		CFTimeInterval duration = 0.3;
		
		[self.strokes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			
			CAShapeLayer *shapeLayer = obj;
			
			NSDictionary *animatedProperties = @{
												 @"opacity": @(shapeLayer.opacity),
												 @"path": (__bridge id)shapeLayer.path
												 };
			
			NSMutableDictionary *animations = [NSMutableDictionary dictionary];
			
			// Prepare animations from values
			for (NSString *propertyKey in [animatedProperties allKeys]) {
				CABasicAnimation *shapeLayerAnimation = [CABasicAnimation animationWithKeyPath:propertyKey];
				shapeLayerAnimation.duration = duration;
				shapeLayerAnimation.timingFunction = timingFunction;
				
				// Set From to current value of presentation layer
				id currentValue = [((CAShapeLayer *)shapeLayer.presentationLayer) valueForKeyPath:propertyKey];
				shapeLayerAnimation.fromValue = currentValue;
				
				// remember animation in dict
				animations[propertyKey] = shapeLayerAnimation;
			}
			
			
			// modify layer
			lineAnimationsBlock(obj, idx, innerBounds);
			
			// finish animations to values
			for (NSString *propertyKey in [animatedProperties allKeys]) {
				// fetch remembered animation from block
				CABasicAnimation *shapeLayerAnimation = animations[propertyKey];
				
				// Update to values to new values
				shapeLayerAnimation.toValue = [shapeLayer valueForKeyPath:propertyKey];
				[shapeLayer addAnimation:shapeLayerAnimation forKey:propertyKey];
			}
			
			animatedProperties = nil;
			animations = nil;
			
		}];
		
		
		CABasicAnimation *layerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
		layerAnimation.duration = duration;
		layerAnimation.timingFunction = timingFunction;
		
		// Set From to current value of presentation layer
		id currentValue = [((CAShapeLayer *)self.layer.presentationLayer) valueForKeyPath:@"transform.rotation.z"];
		layerAnimation.fromValue = currentValue;
		
		layerAnimationsBlock();
		
		layerAnimation.toValue = [self.layer valueForKeyPath:@"transform.rotation.z"];
		[self.layer addAnimation:layerAnimation forKey:@"transform.rotation.z"];
		
		
	} else {
		
		[self.strokes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			lineAnimationsBlock(obj, idx, innerBounds);
		}];
		
		layerAnimationsBlock();
	}
}

@end
