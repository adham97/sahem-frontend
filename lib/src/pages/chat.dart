import 'package:sahem/src/elements/ChatList.dart';

import 'data.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import '../controllers/chat_controller.dart';
import '../elements/ChatBubble.dart';
import '../models/user.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class ChatWidget extends StatefulWidget {
  final User user;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ChatWidget({Key key, this.user, this.parentScaffoldKey}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends StateMVC<ChatWidget> {

  ChatController _con;
  _ChatWidgetState() : super(ChatController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.userRole = widget.user.userRole;
    _con.listenForMessages(userId: widget.user.id);
    _con.length = messages.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _con.getCondition();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () {
            if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
              Navigator.of(context).pushReplacementNamed('/Pages', arguments: 3);
            else if(currentUser.value.userRole == '3')
              Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
            else if(currentUser.value.userRole == '4')
              Navigator.of(context).pushReplacementNamed('/Driver');
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      image: DecorationImage(
                          image: NetworkImage(
                              (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                                  ? widget.user.image
                                  : '${GlobalConfiguration().getString('api_base_url')}images/logo.png'
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                widget.user.online && (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                  ? Positioned(
                  top: 32,
                  left: 32,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: Colors.white, width: 2)),
                  ),
                )
                  : Container()
              ],
            ),
            SizedBox(width: 10),
            Column(
              children: [
                (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                  ? Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                )
                  : SizedBox(height: 0),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 150,
        child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                currentUser.value.userRole == '3'
                    ? Container(
                    height: (_con.questions.length.toDouble() * 50 + 20),
                    padding:  _con.questions.length != 0
                        ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
                        : const EdgeInsets.all(0.0),
                    child: ListView.builder(
                      controller: _con.scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: _con.questions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _con.typeMessage();
                              _con.sendMessage(
                                userId: widget.user.id,
                                content: setting.value.mobileLanguage.value == Locale('en', '')
                                    ? _con.questions.elementAt(index).questionEn
                                    : _con.questions.elementAt(index).questionAr,
                                receive: 'send',
                                messageType: _con.type1,
                                type: _con.type2,
                              );
                            });
                            _con.getAnswer(userId: widget.user.id, questionId: _con.questions.elementAt(index).id);
                            _con.questions.remove(_con.questions.elementAt(index));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).dividerColor.withOpacity(0.9),
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 7,
                                                color: Theme.of(context).hintColor.withOpacity(0.2),
                                              )
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                              setting.value.mobileLanguage.value == Locale('en', '')
                                                  ? _con.questions.elementAt(index).questionEn
                                                  : _con.questions.elementAt(index).questionAr,
                                              style: Theme.of(context).textTheme.bodyText1
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              _con.questions.length != 0
                                  ? SizedBox(height: 10)
                                  : SizedBox(height: 0)
                            ],
                          ),
                        );
                      },
                    )
                )
                    : SizedBox(height: 0),
                ChatList(messages: _con.messages, user: widget.user),
              ],
            )
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2.8,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle, color: Theme.of(context).accentColor),
                    SizedBox(width: 15,),
                    Icon(Icons.camera_alt, color: Theme.of(context).accentColor),
                    SizedBox(width: 15,),
                    Icon(Icons.photo, color: Theme.of(context).accentColor),
                    SizedBox(width: 15,),
                    Icon(Icons.keyboard_voice, color: Theme.of(context).accentColor),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).focusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TextFormField(
                          cursorColor: Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).hintColor
                              : Theme.of(context).primaryColor,
                          controller: _con.sendMessageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Aa",
                            hintStyle: Theme.of(context).textTheme.subtitle2
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      child: MaterialButton(
                        onPressed: () {
                          if(_con.sendMessageController.text != null) {
                            setState(() {
                              (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                                  ?_con.typeReceiveMessage()
                                  : _con.typeMessage();
                              _con.sendMessage(
                                userId: widget.user.id,
                                content: _con.sendMessageController.text,
                                receive: (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                                    ? 'receive'
                                    : 'send',
                                messageType: _con.type1,
                                type: _con.type2
                              );
                              _con.sendMessageController.text = '';
                            });
                          }
                        },
                        child: Icon(Icons.send, color: Theme.of(context).accentColor),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}