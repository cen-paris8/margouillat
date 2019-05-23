import 'step_model.dart';

class GameModel {
  String id;
  String urlId;
  String name;
  String thumbnailUrl;
  String thumbnailPath;
  String shortDescription;
  String description;
  List<AbstractStep> steps;


  GameModel(String name){
    this.name = name;
    this.steps = new List<BaseStepModel>();
  }

  GameModel.fromSnaphot(this.id, this.name, this.urlId, this.shortDescription, this.description){
    this.steps = new List<BaseStepModel>();
  }

  void addStep(BaseStepModel step) {
    this.steps.add(step);
  }
}