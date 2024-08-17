class User{
  static const String collectionName = "User";
  String? id;
  String? fullName;
  String? userName;
  String? email;
  static User instance = User(userName: "AHmed");
  User({this.email , this.fullName , this.id , this.userName});


  User.fromFireStore(Map<String,dynamic>? data){
    id = data?["id"];
    fullName = data?["fullName"];
    userName = data?["userName"];
    email = data?["email"];

  }
  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "fullName":fullName,
      "userName":userName,
      "email":email
    };
  }
}