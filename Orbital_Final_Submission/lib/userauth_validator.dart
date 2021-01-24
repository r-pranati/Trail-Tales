enum FormType{signin, signup}

class EmailValidator{
static String validate(String value){
  if (value.isEmpty) {return "Email can't be empty";}
  else return null;
  // return 
  // value.isEmpty ? "Email can't be empty": null;
  
}

}

class PasswordValidator{
static String validate(String value){
  if (value.isEmpty) {return "Password can't be empty";}
  else if (value.length < 6){return "Password must be atleast 6 characters ";}
  else return null;
  //return value.isEmpty ? "Password can't be empty": null;
}

}