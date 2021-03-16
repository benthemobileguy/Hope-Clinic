import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:path_provider/path_provider.dart';
class FullImageScreen extends StatefulWidget {
  final int healthIndex;

  const FullImageScreen({Key key, this.healthIndex}) : super(key: key);
  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  MainBloc mainBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color:
              primaryColor.withOpacity(0.3),
                  width: 2),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "${bloc.healthTips[healthIndex].files[index]}",
                  ))),
        ),
      ),
    );
  }
}
