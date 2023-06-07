import 'package:cinepebble_social/app/common/animations/lottie_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/models/lottie_animation.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
