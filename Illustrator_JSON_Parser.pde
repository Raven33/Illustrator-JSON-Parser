/* //<>//
Illustrator JSON parser by Arthur Delon
this script depend on Adobe Illustrator, and the Adobe Illustrator extention: Draw2script by GreyRook (see https://github.com/GreyRook/Draw2Script)
contact: arthur.delon@orange.fr
see 
*/

void setup(){
  selectInput("Select a JSON file to proceed", "fileSelected");
}

void function(String path){
  JSONObject test = loadJSONObject(path);
  JSONObject selection = test.getJSONArray("selection").getJSONObject(0);
  JSONArray pathItems = selection.getJSONArray("pathItems");
  for(int i = 0;i<pathItems.size();i++){
    JSONArray pathPoints = pathItems.getJSONObject(i).getJSONArray("pathPoints");
    println("beginShape();");
    JSONArray previousright = null;
    for (int j = 0; j < pathPoints.size(); j++) {
      JSONObject actual = pathPoints.getJSONObject(j);
      JSONArray anchor = actual.getJSONArray("anchor");
      JSONArray left = actual.getJSONArray("leftDirection");
      JSONArray right = actual.getJSONArray("rightDirection");
      if(j == 0){
        println("vertex("+int(anchor.getFloat(0))+","+int(anchor.getFloat(1))+");");
        previousright = right;
      }else{
        println("bezierVertex("+int(previousright.getFloat(0))+","+int(previousright.getFloat(1))+","+int(left.getFloat(0))+","+int(left.getFloat(1))+","+int(anchor.getFloat(0))+","+int(anchor.getFloat(1))+");");
        previousright = right;
      }
    }
    println("endShape();");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    function(selection.getAbsolutePath());
  }
}
