enum EnumStepType {
  intro,
  mapin,
  map,
  qcm,
  puzzle,
  audio,
  enigma,
  end,
  qrcode,
  video
}


class StepType {

  static const Intro = "intro";
  static const MapIn = "map-in";
  static const Map= "map";
  static const QCM= "qcm";
  static const Puzzle = "puzzle";
  static const Enigma = "audio";
  static const End = "final";
  static const QRCode = "QRCode";
  static const Video = "video";

  const StepType();

}

abstract class AbstractStep {

}

// https://gist.github.com/dmundt/3989840
class BaseStepModel extends AbstractStep {
  
  String type;
  String title;
  String shortDescription;
  String description;
  String info;

  BaseStepModel();

  BaseStepModel.fromStepModel(BaseStepModel stepModel) {
    this.type = stepModel.type;
    this.title = stepModel.title;
    this.shortDescription = stepModel.shortDescription;
    this.description = stepModel.description;
    this.info = stepModel.info;
  }

  BaseStepModel.fromSnapthot(this.type, this.title, this.shortDescription, this.description, this.info);



  // void render ();

}

class IntroStepModel extends BaseStepModel {

  String image;
  
  IntroStepModel(BaseStepModel base) : super.fromStepModel(base);

}

class MapInStepModel extends BaseStepModel {
  
  MapInStepModel(BaseStepModel base) : super.fromStepModel(base);

}

class MapStepModel extends BaseStepModel {
   
  double lng;
  double lat;

  MapStepModel(BaseStepModel base) : super.fromStepModel(base);

}

class BaseChallengeStepModel extends BaseStepModel {

  String winMsg;
  List<String> errMsg;

  BaseChallengeStepModel(BaseStepModel base) : super.fromStepModel(base) {
    this.errMsg = new List<String>();
  }

  BaseChallengeStepModel.fromChallengeStepModel(BaseChallengeStepModel base);

  void addErrMsg(String msg) {
    this.errMsg.add(msg);
  }

}

class QCMStepModel extends BaseChallengeStepModel {
  
  List<String> qcm;
  String answer;

  QCMStepModel(BaseChallengeStepModel base) : super.fromChallengeStepModel(base){
    this.qcm = new List<String>();
  }

  QCMStepModel.fromBaseStep(BaseStepModel base) : super(base) {
    this.qcm = new List<String>();
  }

  void addQCMItem(String item) {
    this.qcm.add(item);
  }

  void addQCMItems(List<String> items) {
    this.qcm.addAll(items);
  }

}

class PuzzleStepModel extends BaseStepModel {
  
  String winMsg;
  List<String> errMsg;
  Map<int, String> images;
  
  PuzzleStepModel() : super();

}

class AudioStepModel extends BaseStepModel {
  
  String winMsg;
  List<String> errMsg;
  Map<int, String> images;
  
  AudioStepModel() : super();

}

class EnigmaStepModel extends BaseStepModel {
  
  String winMsg;
  List<String> errMsg;
  Map<String, String> infos;
  
  EnigmaStepModel() : super();

}

class EndStepModel extends BaseStepModel {
  
    EndStepModel() : super();

}

class QRMessageStepModel extends BaseStepModel {
  
  String winMsg;
  List<String> errMsg;
  String qrCode;

  QRMessageStepModel() : super();

}

class VideoStepModel extends BaseStepModel {
  
  String winMsg;
  List<String> errMsg;
  String src;
  String poster;

  VideoStepModel() : super();

}




