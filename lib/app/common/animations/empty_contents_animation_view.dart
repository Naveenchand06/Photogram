import 'package:cinepebble_social/app/common/animations/lottie_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/models/lottie_animation.dart';

class EmptyContentsAnimationView extends LottieAnimationView {
  const EmptyContentsAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
