import 'dart:convert';

enum EnumStepType {
  intro,
  mapin,
  map,
  mcq,
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
  static const Map = "map";
  static const MCQ = "mcq";
  static const Puzzle = "puzzle";
  static const Enigma = "audio";
  static const End = "final";
  static const QRCode = "QRCode";
  static const Video = "video";

  const StepType();

}

abstract class AbstractStep {

  int get index;

}

// https://gist.github.com/dmundt/3989840
class BaseStepModel extends AbstractStep {
  
  String type;
  int index;
  String title;
  String shortDescription;
  String description;
  String info;

  BaseStepModel();

  BaseStepModel.fromStepModel(BaseStepModel stepModel) {
    this.type = stepModel.type;
    this.index = stepModel.index;
    this.title = stepModel.title;
    this.shortDescription = stepModel.shortDescription;
    this.description = stepModel.description;
    this.info = stepModel.info;
  }

  BaseStepModel.fromSnapthot(this.type, this.index, this.title, this.shortDescription, this.description, this.info);

  // void render ();
  
  dynamic get toJson {
    final map = <String, dynamic>{
      'type': type,
      'index': index,
      'title': title,
      'shortDescription': shortDescription,
      'accurdescriptionacy': description,
      'info': info
    };

    return map;
}

  String toString() {
    return 'StepModel${json.encode(this.toJson)}';
  }

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

  void addErrMessage(String msg) {
    this.errMsg.add(msg);
  }

  void addErrMessages(List<String> messages) {
    this.errMsg.addAll(messages);
  }

}

class MCQStepModel extends BaseChallengeStepModel {
  
  List<String> choices;
  int correctAnswser;

  MCQStepModel(BaseChallengeStepModel base) : super.fromChallengeStepModel(base){
    this.choices = new List<String>();
  }

  MCQStepModel.fromBaseStep(BaseStepModel base) : super(base) {
    this.errMsg = new List<String>();
    this.choices = new List<String>();
  }

  void addChoice(String item) {
    this.choices.add(item);
  }

  void addChoices(List<String> items) {
    this.choices.addAll(items);
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




