import 'dart:core';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/url_launcher.dart';



void main() {
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Illumination Repairs',
      home: SafeArea(
        child:DefaultTabController(
        length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Illumination Repairs"),
              backgroundColor: Colors.black,
              bottom: const TabBar(
                tabs: [
                  Tab(icon:Icon(Icons.home),text: "Home",),
                  Tab(icon:Icon(Icons.email),text: "Email",),
                  Tab(icon:Icon(Icons.web),text: "Web Page",),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                HomeVideo(),
                EmailPage(),
                WebPage(),
              ],
            ),
          )
        ),
      ),
    );
  }
}


class HomeVideo extends StatefulWidget{
  const HomeVideo({Key? key}) : super(key: key);
  @override
  _HomeVideoState createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/illuminationrepairs_video.mp4")
      ..initialize().then((_){
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child:Scaffold(
          body:SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
              ),
            ),
          ),
      ),
    )
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  List<String> attachments = [];
  bool isHTML = false;

  String attachment = ' ';

  final _recipientController = TextEditingController(
    text: 'paulcullenphotography@gmail.com',
  );

  final _subjectController = TextEditingController();
  String subjectEntry = ' ';

  final _nameController = TextEditingController();

  String nameEntry = ' ';

  final _emailController = TextEditingController();

  String emailEntry= ' ';

  final _phoneController = TextEditingController();
  String phoneEntry = ' ';

  final _makeController = TextEditingController();
  String makeEntry = ' ';

  final _modelController = TextEditingController();
  String modelEntry = ' ';

  final _detailsController = TextEditingController();
  String detailsEntry = ' ';


  getTextInputData(){

    setState((){
      nameEntry = _nameController.text;
      emailEntry = _emailController.text;
      phoneEntry = _phoneController.text;
      makeEntry = _makeController.text;
      modelEntry = _modelController.text;
      detailsEntry = _detailsController.text;
      subjectEntry = _subjectController.text;
    });
  }

  @override
  void dispose()
  {
    // Clean up the controller when the widget is disposed.
    _recipientController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _subjectController.dispose();
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }


  Future<void> send() async {

    final Email email = Email(
      body: "${_nameController.text}\n${_emailController.text}\n${_makeController.text}\n${_modelController.text}\n${_detailsController.text}",
      subject: _subjectController.text,
      recipients: ['paulcullenphotography@gmail.com'],
      cc: [' '],
      bcc: [' '],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );


    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final Widget imagePath = Text(attachment);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email To Illumination Repairs'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number - Optional',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _makeController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Make',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _modelController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Model',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _detailsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        labelText: 'Details', border: OutlineInputBorder()),
                  ),
                ),
                imagePath,
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.camera),
        label: const Text('Add Image'),
        backgroundColor: Colors.black,
        onPressed: _openImagePicker,
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachment = (pick.path);
      });
    }
  }
}


class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  List<String> recipientEmail = ['paulcullenphotography@gmail.com'];


  List<String> attachments = [];
  bool isHTML = false;

  String attachment = ' ';


  Future<void> send() async {
    final Email email = Email(
      subject: ' ',
      body: ' ',
      recipients: ['paulcullenphotography@gmail.com'],
      cc: [' '],
      bcc: [' '],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );


    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  facebook() async {
    var url = Uri.parse('https://www.facebook.com/IlluminationRepairs');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

    website() async {
      var url = Uri.parse('https://www.illuminationrepairs.org.uk/');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(primary: Colors.black,
        textStyle: const TextStyle(fontSize: 30, color: Colors.white));


    return Scaffold(
            appBar: AppBar(
              title: const Text('Website and Social Media'),
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        FlutterSocialButton(
                          onTap: send,
                          mini: true,
                          buttonType: ButtonType.email,
                          iconColor: Colors.amber,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        //For facebook Button
                        FlutterSocialButton(
                          onTap: facebook,
                          mini: true, // Just pass true for mini buttons
                          buttonType: ButtonType.facebook,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        ElevatedButton(
                          style: style,
                          onPressed: website,
                          child: const Text('Website'),
                        ),
                      ]
                  ),
                ),
              ),
            )
        );
      }
    }












