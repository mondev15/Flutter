# $ download flutter and unzip to C:\src
---> add path to env variable
# open terminal (cmd)
# download git
# download android studio (make sure android sdk comes with)
# add flutter and dart plugins android studio plugins
# $ flutter doctor 

---> if errors 

 # $flutter channel dev
 # $flutter upgrade
 # $flutter config --android-studio-dir="C:\Program Files\Android\Android Studio"
 # $ flutter doctor v 
 
 there must be no errors

--> errors to import http

add this to pubspec.yaml

# dependencies:
  http: ^0.12.0 // latest one might change
Install it You can install packages from the command line:

with Flutter:

# $ flutter packages get

Import it Now in your Dart code, you can use:
# import 'package:http/http.dart';