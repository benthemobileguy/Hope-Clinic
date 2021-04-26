import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
class FullImageScreen extends StatefulWidget {
  final int healthIndex;
  final int index;

  const FullImageScreen({Key key, this.healthIndex, this.index}) : super(key: key);
  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  MainBloc mainBloc;
  bool isInitialised = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(!isInitialised){
      mainBloc = Provider.of<MainBloc>(context, listen:false);
      if(!mainBloc.healthTips[widget.healthIndex].files[widget.index].contains(".jpg")){
        _controller = VideoPlayerController.network(
            mainBloc.healthTips[widget.healthIndex].files[widget.index]);
        _initializeVideoPlayerFuture = _controller.initialize();
        _controller.setLooping(true);
        _controller.setVolume(1.0);
        isInitialised = true;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:mainBloc.healthTips[widget.healthIndex].files[widget.index].contains(".jpg")?
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color:
              primaryColor.withOpacity(0.3),
                  width: 2),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "${mainBloc.healthTips[widget.healthIndex].files[widget.index]}",
                  ))),
        ): FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton:!mainBloc.healthTips[widget.healthIndex].files[widget.index].contains(".jpg")?
        FloatingActionButton(
          materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child:
          Icon(_controller.value.isPlaying ?
          Icons.pause : Icons.play_arrow, color: primaryColor,size: 30,),
        ):Container(),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
