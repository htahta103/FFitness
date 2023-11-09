// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

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
    _pageController = PreloadPageController(initialPage: widget.index);
    _currentPageController = BehaviorSubject<int>();
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
        preloadPagesCount: 5,
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
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeController();
  }

  bool _videoInitialized = false;

  initializeController() async {
    var fileInfo = await kCacheManager.getFileFromCache(widget.reelUrl);
    if (fileInfo == null) {
      await kCacheManager.downloadFile(widget.reelUrl);
      fileInfo = await kCacheManager.getFileFromCache(widget.reelUrl);
    }
    if (mounted) {
      _controller = VideoPlayerController.file(fileInfo!.file)
        ..initialize().then((value) {
          _controller?.play();
          _controller?.pause();

          widget.pageIndex.listen((currentIndex) {
            print(currentIndex);
            if (widget.index == currentIndex) {
              setState(() {
                _controller?.play();
                _videoInitialized = true;
              });
            }
          });
        });
    }
  }

  bool _isPlaying = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
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
      // App is terminated
      _controller?.dispose();
    }
  }

  @override
  void dispose() {
    print('disposing a controller');
    if (mounted) {
      _controller?.dispose();
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
            onTap: () {
              if (_videoInitialized) {
                setState(() {
                  if (_controller?.value.isPlaying ?? false) {
                    _controller?.pause();
                    _isPlaying = false;
                  } else {
                    _controller?.play();
                    _isPlaying = true;
                  }
                });
              }
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                !_videoInitialized && _controller == null
                    // when the video is not initialized you can set a thumbnail.
                    // to make it simple, I use CircularProgressIndicator
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      )
                    : VideoPlayer(_controller!),
                !_videoInitialized
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      )
                    : const SizedBox(),
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
                        colors: const VideoProgressColors(
                          playedColor: Colors.amber,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                      )
              ],
            ),
          ),
          // here you can add title, user Info,
          // description, views count etc.
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
    'https://assets.mixkit.co/videos/preview/mixkit-aerial-panorama-of-a-landscape-with-mountains-and-a-lake-4249-large.mp4/',
    'https://assets.mixkit.co/videos/preview/mixkit-curvy-road-on-a-tree-covered-hill-41537-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-frying-diced-bacon-in-a-skillet-43063-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-fresh-apples-in-a-row-on-a-natural-background-42946-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-rain-falling-on-the-water-of-a-lake-seen-up-18312-large.mp4',
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
