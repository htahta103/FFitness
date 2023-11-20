// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:like_button/like_button.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:rxdart/rxdart.dart';

class Reels extends StatefulWidget {
  const Reels({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  @override
  Widget build(BuildContext context) {
    return VideoReelPage(
      index: 0, // if you want to go to any specific index
      reels: ReelService().getReels(),
      onPageChange: (index) {
        print('current index = ' + index.toString());
      },
    );
  }
}

class VideoReelPage extends StatefulWidget {
  const VideoReelPage(
      {super.key, required this.reels, required this.index, this.onPageChange});
  final List<String> reels;
  final Function? onPageChange;
  final int index;

  @override
  _VideoReelPageState createState() => _VideoReelPageState();
}

class _VideoReelPageState extends State<VideoReelPage> {
  late PreloadPageController _pageController;
  int currentPage = 0;
  late BehaviorSubject<int> _currentPageController;
  @override
  void initState() {
    super.initState();
    _pageController =
        PreloadPageController(initialPage: widget.index, keepPage: true);
    _currentPageController = BehaviorSubject<int>();
    _currentPageController.sink.add(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PreloadPageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.reels.length,
        preloadPagesCount: 10,
        onPageChanged: (index) {
          currentPage = index;
          _currentPageController.sink.add(index);
        },
        itemBuilder: (context, index) {
          return VideoPlayerWidget(
              key: Key(widget.reels[index]),
              reelUrl: widget.reels[index],
              pageIndex: _currentPageController,
              index: index);
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String reelUrl;
  final int index;
  final BehaviorSubject<int> pageIndex;

  const VideoPlayerWidget({
    super.key,
    required this.reelUrl,
    required this.pageIndex,
    required this.index,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  VideoPlayerController? _controller;
  late BehaviorSubject<bool> heartController;
  bool _isDoubleTapDetected = false;
  late AnimationController cdSpinController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    heartController = BehaviorSubject<bool>();
    cdSpinController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      initializeController();
    });
  }

  bool _videoInitialized = false;

  initializeController() async {
    print('render ne ${widget.index}');
    var fileInfo = await kCacheManager.getFileFromCache(widget.reelUrl);
    if (fileInfo == null) {
      await kCacheManager.downloadFile(widget.reelUrl);
      fileInfo = await kCacheManager.getFileFromCache(widget.reelUrl);
    }
    // if (mounted) {

    _controller = VideoPlayerController.file(fileInfo!.file,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((value) {
        _videoInitialized = true;
        setState(() {});
        widget.pageIndex.listen((currentIndex) {
          if (widget.index == currentIndex) {
            _isPlaying = true;
            setState(() {});
            _controller?.play();
            cdSpinController.repeat();
          } else {
            _controller!.seekTo(Duration.zero);
          }
        });
      });
    // }
  }

  bool _isPlaying = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state ne => ' + state.toString());
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      _controller?.play();
    } else if (state == AppLifecycleState.inactive) {
      // App is partially obscured
      _controller?.pause();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
      _controller?.pause();
    } else if (state == AppLifecycleState.detached) {
      _controller?.dispose();
    }
    // }
  }

  @override
  void dispose() {
    print('disposing a controller');
    if (mounted) {
      _controller?.dispose();
      heartController.close();
      cdSpinController.dispose();
    } // Dispose of the controller when done
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!_isDoubleTapDetected && _videoInitialized) {
                setState(() {
                  if (_controller?.value.isPlaying ?? false) {
                    _controller?.pause();
                    cdSpinController.stop();
                    _isPlaying = false;
                  } else {
                    _controller?.play();
                    cdSpinController.repeat();
                    _isPlaying = true;
                  }
                });
              }
            },
            onDoubleTap: () {
              _isDoubleTapDetected = true;
              Future.delayed(const Duration(milliseconds: 1000), () {
                _isDoubleTapDetected = false;
              });
              heartController.sink.add(true);
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                !_videoInitialized && _controller == null
                    // when the video is not initialized you can set a thumbnail.
                    // to make it simple, I use CircularProgressIndicator
                    ? Center(
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      )
                    : VideoPlayer(_controller!),
                if (!_isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                !_videoInitialized && _controller == null
                    ? const SizedBox()
                    : VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: FlutterFlowTheme.of(context).primary,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                      ),
                HeartAnimation(
                    animateStream: heartController,
                    duration: const Duration(seconds: 3)),
              ],
            ),
          ),
          // here you can add title, user Info,
          // description, views count etc.

          VideoContentWidget(
            likeController: heartController,
            cdSpinController: cdSpinController,
          )
        ],
      ),
    );
  }
}

const kReelCacheKey = "reelsCacheKey";
final kCacheManager = CacheManager(
  Config(
    kReelCacheKey,
    stalePeriod: const Duration(days: 7), // Maximum cache duration
    maxNrOfCacheObjects: 100, // maximum reels to cache
    repo: JsonCacheInfoRepository(databaseName: kReelCacheKey),
    // fileSystem: IOFileSystem(kReelCacheKey),
    fileService: HttpFileService(),
  ),
);

class ReelService {
  // Here, I use some stock videos as an example.
// But you need to make this list empty when you will call api for your reels
  final _reels = <String>[
    'https://www.dropbox.com/scl/fi/uqy9r3p1xovbyu70ekvm6/Snaptik.app_7240228852037995802.mp4?rlkey=jl2padl64qw6h1w36xelgpj6a&raw=1',
    'https://www.dropbox.com/scl/fi/0tjqbkjgyj00ql37y365f/Snaptik.app_7301969920437406977.mp4?rlkey=rlkjksm3lhl1ekkz2qqonywgg&raw=1',
    'https://assets.mixkit.co/videos/preview/mixkit-man-doing-pull-ups-wearing-face-mask-40157-large.mp4',
    'https://www.dropbox.com/scl/fi/wxqldgdpmr6i3rvedo4ji/SnapTik_7177630540961434892.mp4?rlkey=4htlu8s1nlhit0g40mrcxj3pg&raw=1',
    'https://www.dropbox.com/scl/fi/91yh0iiwv7cj0i9x3ebsa/SnapTik_7258434458456558889.mp4?rlkey=dkvlg608jtmkmu98hmqeimqdu&raw=1',
    'https://www.dropbox.com/scl/fi/3j8r2zss50uv402fkh7vi/SnapTik_7291173229052316943.mp4?rlkey=ue6fx8oanpinkz2cwv4acjqj0&raw=1',
    'https://www.dropbox.com/scl/fi/x9w7c0jfje9ulbpqp4nnj/SnapTik_7294887134303882534.mp4?rlkey=t8ls87hu6f4ipc5a1pew9m1nx&raw=1',
    'https://www.dropbox.com/scl/fi/zn06bxkbzbo1crtr8j553/SnapTik_7300032482160692495.mp4?rlkey=52h524cttyw9ncst3s6wgla86&raw=1',
    'https://www.dropbox.com/scl/fi/h63rh1ke4gcgb81a3nf2o/Snaptik.app_7207018258753457434.mp4?rlkey=rm2q3dmh81v9szfn2ix2va98g&raw=1',

    // 'https://assets.mixkit.co/videos/preview/mixkit-curvy-road-on-a-tree-covered-hill-41537-large.mp4',
    // 'https://assets.mixkit.co/videos/preview/mixkit-frying-diced-bacon-in-a-skillet-43063-large.mp4',
    // 'https://assets.mixkit.co/videos/preview/mixkit-fresh-apples-in-a-row-on-a-natural-background-42946-large.mp4',
    // 'https://assets.mixkit.co/videos/preview/mixkit-rain-falling-on-the-water-of-a-lake-seen-up-18312-large.mp4',
  ];

  Future getVideosFromApI() async {
    // call your api here
    // then add all links to _reels variable
    for (var i = 0; i < _reels.length; i++) {
      cacheVideos(_reels[i], i);
      // you can add multiple logic for to cache videos. Right now I'm caching all videos
    }
  }

  cacheVideos(String url, int i) async {
    FileInfo? fileInfo = await kCacheManager.getFileFromCache(url);
    if (fileInfo == null) {
      print('downloading file ##------->$url##');
      await kCacheManager.downloadFile(url);
      print('downloaded file ##------->$url##');
      if (i + 1 == _reels.length) {
        print('caching finished');
      }
    }
  }

  List<String> getReels() {
    return _reels;
  }
}

class VideoContentWidget extends StatefulWidget {
  final BehaviorSubject<bool> likeController;
  final AnimationController cdSpinController;

  const VideoContentWidget(
      {super.key,
      required this.likeController,
      required this.cdSpinController});

  @override
  State<VideoContentWidget> createState() => _VideoContentWidgetState();
}

class _VideoContentWidgetState extends State<VideoContentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: ContentInfo(
          //     uiModel: widget.data,
          //   ),
          // ),
          Positioned.fill(
              right: 0,
              bottom: 0,
              left: MediaQuery.of(context).size.width - 60,
              child: actionsSection()),
        ],
      ),
    );
  }

  Widget actionsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // MCircleButton(
        //   size: AppDimens.circleButtonSize.h,
        // ),
        StreamBuilder<bool>(
            stream: widget.likeController,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return LikeButton(
                isLiked: snapshot.data,
                padding: const EdgeInsets.symmetric(vertical: 10),
                countPostion: CountPostion.bottom,
                likeCount: 100,
                onTap: (onTap) async {
                  widget.likeController.sink.add(!onTap);
                  return !onTap;
                },
                likeBuilder: (isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  );
                },
              );
            }),
        LikeButton(
          onTap: (isLiked) async {
            await showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const CommentsSection();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.transparent,
            );
            return false;
          },
          padding: const EdgeInsets.symmetric(vertical: 10),
          likeBuilder: (isLiked) => Icon(
            Icons.comment,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
          likeCount: 888,
          countPostion: CountPostion.bottom,
        ),
        LikeButton(
          onTap: (isLiked) async {
            return false;
          },
          padding: const EdgeInsets.symmetric(vertical: 10),
          likeBuilder: (isLiked) => Icon(
            Icons.share,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
          countPostion: CountPostion.bottom,
        ),
        //   saveButton(),
        CircleMusicWidget(
          controller: widget.cdSpinController,
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
//   Widget saveButton() {
//     return LikeButton(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       onTap: ((isLiked) async {
//         return !isLiked;
//       }),
//       size: AppDimens.buttonSize.h,
//       isLiked: false,
//       circleColor: CircleColor(
//         start: Colors.grey[200]!,
//         end: Colors.grey[400]!,
//       ),
//       bubblesColor: BubblesColor(
//         dotPrimaryColor: Colors.grey[600]!,
//         dotSecondaryColor: Colors.grey[200]!,
//       ),
//       likeBuilder: (bool isLiked) {
//         return Icon(
//           Icons.bookmark,
//           color: isLiked ? Colors.yellow : Colors.white,
//           size: AppDimens.buttonSize.h,
//         );
//       },
//       likeCount: 888,
//       countPostion: CountPostion.bottom,
//       countBuilder: (int? count, bool isLiked, String text) {
//         return Text(
//           count == 0 ? 'love' : text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }

class HeartAnimation extends StatefulWidget {
  final Stream<bool> animateStream;
  final Duration duration;
  const HeartAnimation(
      {super.key, required this.animateStream, required this.duration});
  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacityIn;
  late Animation<double> opacityOut;
  late Animation<double> rotate;
  late Animation<RelativeRect> transform;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    //Stagging animation
    scale = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    opacityIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    opacityOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.4,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    transform = RelativeRectTween(
            begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
            end: const RelativeRect.fromLTRB(0, -300, -300, 0))
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.4,
          1,
          curve: Curves.linear,
        ),
      ),
    );
    rotate = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.4,
          1,
          curve: Curves.ease,
        ),
      ),
    );
    widget.animateStream.listen((event) {
      if (event) {
        print('animate ne');
        doAnimation();
      }
    });
  }

  Future doAnimation() async {
    controller.stop();
    controller.reset();
    await controller.forward();
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: transform,
      child: RotationTransition(
        turns: rotate,
        child: ScaleTransition(
          scale: scale,
          child: FadeTransition(
            opacity: opacityOut,
            child: FadeTransition(
              opacity: opacityIn,
              child: IgnorePointer(
                child: Icon(
                  Icons.favorite_rounded,
                  size: 100,
                  color: FlutterFlowTheme.of(context).error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 300,
          child: Container(
            color: FlutterFlowTheme.of(context).primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Text(
                      '2 Comments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: FlutterFlowTheme.of(context).primaryText),
                    )),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () async {
                        // context.safePop();
                      },
                    ),
                  ],
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                        CommentWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // MediaQuery.of(context).viewInsets.bottom > 0
        //     ? Positioned.fill(
        //         child: MInkwell(
        //           child: Container(
        //             color: Colors.red,
        //           ),
        //         ),
        //       )
        //     : const SizedBox(),
        const Align(
          alignment: Alignment.bottomCenter,
          child: TextField(),
        )
      ],
    );
  }
}

//CD playing widget

class CircleContainer extends StatelessWidget {
  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final bool? haveBorder;
  final Gradient? gradient;
  final double? size;
  const CircleContainer(
      {super.key,
      this.bgColor,
      required this.child,
      this.margin,
      this.padding,
      this.haveBorder,
      this.gradient,
      this.size,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: gradient != null ? null : (bgColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(45),
        gradient: gradient,
        border: haveBorder ?? true
            ? Border.all(color: borderColor ?? Colors.white, width: 2)
            : null,
        boxShadow: const [
          // BoxShadow(
          //   blurRadius: AppDimens.kBlurRadiusTopBar.w,
          //   offset: Offset(0, 4.h),
          //   color: AppColors.boxShadow,
          // )
        ],
      ),
      child: child,
    );
  }
}

class CircleAnimatedContainer extends StatelessWidget {
  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final bool? haveBorder;
  final Gradient? gradient;
  final double? size;
  final AnimationController controller;
  const CircleAnimatedContainer({
    super.key,
    this.bgColor,
    required this.child,
    this.margin,
    this.padding,
    this.haveBorder,
    this.gradient,
    this.size,
    required this.controller,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
      child: CircleContainer(
        bgColor: bgColor,
        margin: margin,
        padding: padding,
        haveBorder: haveBorder,
        gradient: gradient,
        size: size,
        borderColor: borderColor,
        child: child,
      ),
    );
  }
}

class CircleMusicWidget extends StatelessWidget {
  final AnimationController controller;
  const CircleMusicWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAnimatedContainer(
          controller: controller,
          haveBorder: false,
          size: 49,
          gradient: cdGradient,
          child: Center(
              child: Icon(
            Icons.music_note,
            color: FlutterFlowTheme.of(context).primaryText,
          )),
        ),
      ],
    );
  }
}

final LinearGradient cdGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [
      0.1257,
      0.3838,
      0.6278,
      0.8803,
    ],
    colors: [
      const Color(0xFF171717).withOpacity(1),
      const Color(0xFF373736).withOpacity(1),
      const Color(0xFF171717).withOpacity(1),
      const Color(0xFF373736).withOpacity(1)
    ]);

/// End CD playing

/// Comment Widget
class CommentWidget extends StatelessWidget {
  final String? user;
  final String? comment;
  const CommentWidget({super.key, this.user, this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MCircleButton(
            margin: const EdgeInsets.only(right: 5),
            size: 30,
            bgColor: FlutterFlowTheme.of(context).primary,
            haveAddFriendButton: false,
          ),
          Expanded(child: content(context)),
        ],
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user ?? 'Username',
          style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText, fontSize: 14),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          comment ?? 'Comment',
          style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText, fontSize: 12),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: Text('2h')),
            LikeButton(
              size: 15,
              countPostion: CountPostion.right,
              likeCount: 0,
              likeBuilder: (isLiked) => isLiked
                  ? Icon(
                      Icons.favorite_rounded,
                      color: FlutterFlowTheme.of(context).error,
                      size: 15,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      color: FlutterFlowTheme.of(context).error,
                      size: 15,
                    ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        )
      ],
    );
  }
}

class MCircleButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final double? size;
  final Color? bgColor;
  final Color? borderColor;
  final VoidCallback? addFriendColors;
  final bool haveAddFriendButton;
  final EdgeInsets? margin;
  const MCircleButton(
      {Key? key,
      this.child,
      this.onPressed,
      this.size,
      this.bgColor,
      this.addFriendColors,
      this.haveAddFriendButton = true,
      this.margin,
      this.borderColor})
      : super(key: key);

  @override
  State<MCircleButton> createState() => _MCardState();
}

class _MCardState extends State<MCircleButton>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleContainer(
          margin: widget.margin ??
              const EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
          bgColor: widget.bgColor,
          borderColor: widget.borderColor,
          child: InkWell(
            onTap: widget.onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: Center(child: widget.child),
                ),
              ],
            ),
          ),
        ),
        widget.haveAddFriendButton
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleContainer(
                    haveBorder: false,
                    padding: const EdgeInsets.all(1),
                    bgColor: FlutterFlowTheme.of(context).error,
                    child: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 15,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

extension VideoExtension on VideoPlayerController? {
  Future setPlay() async {
    if (this?.value == null) return;
    if (!this!.value.isPlaying) await this!.play();
  }

  Future setStop() async {
    if (this?.value == null) return;
    if (this!.value.isPlaying) await this!.pause();
  }

  Future reset() async {
    if (this?.value == null) return;

    if (this!.value.isPlaying) await this!.pause();
    await this!.seekTo(Duration.zero);
  }

  Future onTapVideo() async {
    if (!this!.value.isPlaying) {
      await this!.play();
    } else {
      await this!.pause();
    }
  }
}
